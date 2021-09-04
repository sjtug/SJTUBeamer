#!/bin/bash

set -e

git ls-files | grep .dtx$ | xargs -n1 latexindent -w $@
git ls-files | grep .tex$ | xargs -n1 latexindent -w $@
