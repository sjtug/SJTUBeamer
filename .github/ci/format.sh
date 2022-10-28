#!/bin/bash

set -e

latexindent -w $@ -sl -t main.tex

git ls-files | grep .tex$ | xargs -n1 latexindent -w $@
