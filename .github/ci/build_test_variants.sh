#!/bin/bash

set -e

rm -rf build
mkdir -p build

sed -e "s|usetheme\[.*\]|usetheme\[maxplus,light,blue\]|g" main.tex > build/build-blue.tex
sed -e "s|usetheme\[.*\]|usetheme\[max,dark,red\]|g" main.tex              > build/build-red.tex
sed -e "s|usetheme\[.*\]|usetheme\[min,dark,red\]|g" main.tex              > build/build-min.tex

latexmk $@ -outdir=build build/build-*.tex
