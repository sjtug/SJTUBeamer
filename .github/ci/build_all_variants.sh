#!/bin/bash

set -e

mkdir -p build

sed -e "s|usetheme\[.*\]|usetheme\[maxplus,light,blue\]|g" main.tex > build/sjtulib-talk-maxplus-blue.tex
sed -e "s|usetheme\[.*\]|usetheme\[maxplus,dark,red\]|g" main.tex  > build/sjtulib-talk-maxplus-red.tex
sed -e "s|usetheme\[.*\]|usetheme\[max,red\]|g" main.tex             > build/sjtulib-talk-max-red.tex
sed -e "s|usetheme\[.*\]|usetheme\[min,red\]|g" main.tex              > build/sjtulib-talk-min-red.tex

latexmk $@ -outdir=build build/sjtulib-talk-*.tex
