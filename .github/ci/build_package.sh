#!/bin/bash

apk add zip
cd src
l3build ctan
cp build/distrib/tds/tex/latex/sjtubeamer ..
cd ..