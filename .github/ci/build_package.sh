#!/bin/bash

cd src

# This will trigger checkinit_hook() to move the files to the root directory.
l3build ctan
l3build cache-demo # cache demos for making the next ctan process faster
l3build manifest
l3build ctan

cd ..
.github/ci/copy_resources.sh

if [ ! -f src/sjtubeamer-ctan.zip ]; then
    echo "BUILD FAILED."
    exit 1
fi
