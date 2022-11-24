#!/bin/bash

# Overleaf package will be in build/overleaf.
OVERLEAF_DIR=build/overleaf
OVERLEAF_FILENAME=sjtubeamer-overleaf.zip

# Generate the latest files first.
cd src && l3build check && cd ..

# A clean directory start.
rm -rf ${OVERLEAF_DIR}
mkdir -p ${OVERLEAF_DIR}

# contrib
cp -rv contrib ${OVERLEAF_DIR}/

# build
mkdir -p ${OVERLEAF_DIR}/build
echo > ${OVERLEAF_DIR}/build/.gitkeep

# minimal workset
cp -rv vi ${OVERLEAF_DIR}/
cp -v beamer*.sty ${OVERLEAF_DIR}/
cp -v sjtu*.sty ${OVERLEAF_DIR}/

# quick start
cp -v src/doc/sjtubeamerquickstart.tex ${OVERLEAF_DIR}/
cp -v src/doc/ref.bib ${OVERLEAF_DIR}/

# Generate zip
cd ${OVERLEAF_DIR}
zip -r ${OVERLEAF_FILENAME} *
cd -
mv -f ${OVERLEAF_DIR}/${OVERLEAF_FILENAME} ${OVERLEAF_FILENAME}

echo -----------------------------------------------------
echo Overleaf package is generated at ${OVERLEAF_DIR}.
echo Zipped file is at ./${OVERLEAF_FILENAME}.
echo -----------------------------------------------------
