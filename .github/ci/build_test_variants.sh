#!/bin/bash

set -e

rm -rf build

sed -e "s|usetheme\[.*\]|usetheme\[bannertitle,blue\]|g" main.tex > build-bannertitle-blue.tex
sed -e "s|usetheme\[.*\]|usetheme\[red\]|g" main.tex              > build-red.tex

latexmk -C
latexmk $@ build-*.tex

mkdir -p build
mv build-*.pdf build/
rm -f build-*.tex
