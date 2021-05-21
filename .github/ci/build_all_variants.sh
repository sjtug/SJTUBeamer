#!/bin/bash

set -e

sed -i.bak -e "s|usetheme\[.*\]|usetheme\[bannertitle,blue\]|g" main.tex
latexmk -C
latexmk -xelatex
cp main.pdf build/main-bannertitle-blue.pdf

sed -i.bak -e "s|usetheme\[.*\]|usetheme\[bannertitle,red\]|g" main.tex
latexmk -C
latexmk -xelatex
cp main.pdf build/main-bannertitle-red.pdf

sed -i.bak -e "s|usetheme\[.*\]|usetheme\[blue\]|g" main.tex
latexmk -C
latexmk -xelatex
cp main.pdf build/main-blue.pdf

sed -i.bak -e "s|usetheme\[.*\]|usetheme\[red\]|g" main.tex
latexmk -C
latexmk -xelatex
cp main.pdf build/main-red.pdf

sed -i.bak -e "s|usetheme\[.*\]|usetheme\[bannertitle,blue\]|g" main.tex
