# ----------------
# User commands
# ----------------

LATEXINDENT_ARGS=-l latexindent.yaml -c build -m -r
LATEXMK_ARGS=-halt-on-error -time -xelatex -outdir=build -shell-escape

all: build

prepare:
	mkdir -p build
	mkdir -p build/contents

# Build latex files in root directory
build: prepare
	latexmk main.tex $(LATEXMK_ARGS)
	cp build/main.pdf .

# Format tex files in root directory
format:
	latexindent main.tex -l latexindent.yaml -w $(LATEXINDENT_ARGS)

# Clean temporary files
clean:
	latexmk -C $(LATEXMK_ARGS)

# ----------------
# Developer commands
# ----------------

# Format all tex and dtx files
format-dev:
	.github/ci/format.sh $(LATEXINDENT_ARGS)

# Clean all temporary files and generated files
clean-dev:
	latexmk -C
	cd src && l3build clean
	git clean -dfX

# Build all covers to `cover.pdf`
build-cover: prepare
	.github/ci/gen_cover.sh $(LATEXMK_ARGS)
	cp build/cover.pdf .

# Build sjtubeamer package
# This will build online package automatically.
build-dev: prepare
	.github/ci/build_package.sh

# Build online distribution
build-online: prepare
	.github/ci/build_online.sh

# Build `main.tex` with multiple test variants
build-test-variants: prepare
	.github/ci/build_test_variants.sh $(LATEXMK_ARGS)
	cp build/build-*.pdf .

# Build `main.tex` with multiple release variants
build-all-variants: prepare
	.github/ci/build_all_variants.sh $(LATEXMK_ARGS)
	cp build/build-*.pdf .

# Generate `.sty` files and copy resources
generate:
	(cd src/source && latex beamerthemesjtubeamer.ins && mv *.sty ../..)
	.github/ci/copy_resources.sh

.PHONY: build format clean
