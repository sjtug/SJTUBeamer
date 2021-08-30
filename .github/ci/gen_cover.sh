#!/bin/bash

# covers
sed -e "s|<options>|red,light|g" src/doc/cover.template.tex > build/cover-red-light.tex
sed -e "s|<options>|red,dark|g" src/doc/cover.template.tex > build/cover-red-dark.tex
sed -e "s|<options>|blue,light|g" src/doc/cover.template.tex > build/cover-blue-light.tex
sed -e "s|<options>|blue,dark|g" src/doc/cover.template.tex > build/cover-blue-dark.tex

latexmk $@ -outdir=build build/cover-*.tex

# merge covers
cp -f src/doc/cover.tex build/cover.tex
latexmk $@ -outdir=build build/cover.tex
