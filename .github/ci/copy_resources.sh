#!/bin/bash

set -e
resources=(cnlogo.pdf dlogo.pdf enlogo.pdf sjtubadge.pdf sjtuphoto.jpg vlogo.pdf sjtubg.png)
for resource in ${resources[@]};
do
    rm -f $resource
    cp src/source/$resource $resource
done
