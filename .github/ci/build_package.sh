#!/bin/bash

apk add zip diffutils
cd src
l3build ctan
# This will trigger checkinit_hook() to move the files to the root directory.

# turn resource files into symbolic link.
# TODO: a more elegant solution in the future.
cd ..
resources=(cnlogo.pdf dlogo.pdf enlogo.pdf sjtubadge.pdf sjtuphoto.jpg vlogo.pdf sjtubg.png)
for resource in ${resources[@]};
do
    rm -f $resource
    ln -s src/source/$resource $resource
done

if [ ! -f src/sjtubeamer-ctan.zip ]; then
    echo "BUILD FAILED."
    exit 1
fi