#!/bin/bash

cd src
l3build ctan
# This will trigger checkinit_hook() to move the files to the root directory.

# but doesn't move vi/ folder.
cp -r -f src/source/vi vi/

if [ ! -f src/sjtubeamer-ctan.zip ]; then
    echo "BUILD FAILED."
    exit 1
fi
