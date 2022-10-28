#!/bin/bash

set -e

which xargs

git ls-files | grep .tex$ | xargs -n1 echo

git ls-files | grep .tex$ | xargs -n1 latexindent -w $@
