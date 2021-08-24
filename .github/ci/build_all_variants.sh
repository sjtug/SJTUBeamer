#!/bin/bash

set -e

rm -rf build
mkdir -p build

sed -e "s|usetheme\[.*\]|usetheme\[maxplus,light,blue\]|g" main.tex > build/build-maxplus-blue.tex
sed -e "s|usetheme\[.*\]|usetheme\[maxplus,dark,red\]|g" main.tex  > build/build-maxplus-red.tex
sed -e "s|usetheme\[.*\]|usetheme\[max,red\]|g" main.tex             > build/build-max-red.tex
sed -e "s|usetheme\[.*\]|usetheme\[min,red\]|g" main.tex              > build/build-min-red.tex

latexmk $@ -outdir=build build/build-*.tex
