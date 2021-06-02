build:
	latexmk main.tex -halt-on-error -time -xelatex

format:
	latexindent -w -l main.tex

clean:
	latexmk -C

.PHONY: build format clean
