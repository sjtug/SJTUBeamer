#!/bin/bash

# Build online package first.
.github/ci/build_online.sh

cd src

# This will trigger checkinit_hook() to move the files to the root directory.
l3build ctan
l3build cache-demo # cache demos for making the next ctan process faster
l3build manifest
l3build ctan
l3build clean-demo # for a clean restart

cd ..
.github/ci/copy_resources.sh

# Copy to the tds dir for uploading artifacts conveniently.
cp -v sjtubeamer-online.zip src/build/distrib/tds/

if [ ! -f src/sjtubeamer-ctan.zip ]; then
    echo "BUILD CTAN FAILED."
    exit 1
fi