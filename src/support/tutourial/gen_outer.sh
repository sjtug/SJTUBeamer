#!/bin/bash

outers=(default infolines smoothbars sidebar split shadow tree smoothtree)
for outer in ${outers[@]};
do
    sed -e "s|miniframes|$outer|g" step2miniframes.tex > step2$outer.tex
done