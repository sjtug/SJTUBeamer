#!/bin/bash

# Online package will be in build/online.
ONLINE_DIR=build/online
ONLINE_FILENAME=sjtubeamer-online.zip

# Generate the latest files first.
cd src && l3build check && cd ..

# A clean directory start.
rm -rf ${ONLINE_DIR}
mkdir -p ${ONLINE_DIR}

# contrib
cp -rv contrib ${ONLINE_DIR}/

# build
mkdir -p ${ONLINE_DIR}/build
echo > ${ONLINE_DIR}/build/.gitkeep

# minimal workset
cp -rv vi ${ONLINE_DIR}/
cp -v beamer*.sty ${ONLINE_DIR}/
cp -v sjtu*.sty ${ONLINE_DIR}/

# quick start
cp -v src/doc/sjtubeamerquickstart.tex ${ONLINE_DIR}/
cp -v src/doc/ref.bib ${ONLINE_DIR}/

# Generate zip
cd ${ONLINE_DIR}
zip -r ${ONLINE_FILENAME} *
cd -
mv -f ${ONLINE_DIR}/${ONLINE_FILENAME} ${ONLINE_FILENAME}

echo -----------------------------------------------------
echo Online package is generated at ${ONLINE_DIR}.
echo Zipped file is at ./${ONLINE_FILENAME}.
echo -----------------------------------------------------
