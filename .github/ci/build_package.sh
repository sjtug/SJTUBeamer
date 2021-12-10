#!/bin/bash

export diffexe="diff -U 3"
apk add zip diffutils

cd src
l3build ctan
# This will trigger checkinit_hook() to move the files to the root directory.

cd ..
.github/ci/copy_resources.sh

if [ ! -f src/sjtubeamer-ctan.zip ]; then
    echo "BUILD FAILED."
    exit 1
fi
