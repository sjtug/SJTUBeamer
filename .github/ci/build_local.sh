#!/bin/bash

set -e

cd src && l3build ctan

cp -r -f build/distrib/tds/tex/latex/sjtubeamer/* ..

# turn resource files into symbolic link.
# TODO: a more elegant solution in the future.
cd ..
resources=(cnlogo.pdf dlogo.pdf enlogo.pdf sjtubadge.pdf sjtuphoto.jpg vlogo.pdf sjtubg.png)
for resource in ${resources[@]};
do
    rm -f $resource
    ln -s src/source/$resource $resource
done
