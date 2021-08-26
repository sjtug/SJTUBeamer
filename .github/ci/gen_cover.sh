#!/bin/bash

sed -e "s|<options>|red,light|g" src/doc/cover.template.tex > src/doc/cover-red-light.tex
sed -e "s|<options>|red,dark|g" src/doc/cover.template.tex > src/doc/cover-red-dark.tex
sed -e "s|<options>|blue,light|g" src/doc/cover.template.tex > src/doc/cover-blue-light.tex
sed -e "s|<options>|blue,dark|g" src/doc/cover.template.tex > src/doc/cover-blue-dark.tex
