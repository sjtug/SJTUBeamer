#!/bin/bash

apk add zip
cd src
l3build ctan
cp -r build/distrib/tds/tex/latex/sjtubeamer/* ..
cd ..