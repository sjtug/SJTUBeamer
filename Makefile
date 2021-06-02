build:
	latexmk main.tex -halt-on-error -time -xelatex

format:
	latexindent -w -l *.tex
	latexindent -w -l *.sty

clean:
	latexmk -C

.PHONY: build format clean
