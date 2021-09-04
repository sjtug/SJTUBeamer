#!/bin/bash

set -e

sed -e "s|usetheme\[.*\]|usetheme\[maxplus,blue\]|g" main.tex > build/build-blue.tex
sed -e "s|usetheme\[.*\]|usetheme\[max,light,red\]|g" main.tex              > build/build-red.tex
sed -e "s|usetheme\[.*\]|usetheme\[min,dark,red\]|g" main.tex              > build/build-min.tex

latexmk $@ -outdir=build build/build-*.tex