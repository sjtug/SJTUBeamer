#!/bin/bash

apk add zip
cd src
l3build ctan
cp -r -f build/distrib/tds/tex/latex/sjtubeamer/* ..
cd ..