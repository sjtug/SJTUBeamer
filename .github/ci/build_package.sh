#!/bin/bash

cd src
l3build ctan
# This will trigger checkinit_hook() to move the files to the root directory.

# turn resource files into symbolic link.
# TODO: a more elegant solution in the future.
cd ..

.github/ci/copy_resources.sh

if [ ! -f src/sjtubeamer-ctan.zip ]; then
    echo "BUILD FAILED."
    exit 1
fi
