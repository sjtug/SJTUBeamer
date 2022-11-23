# !/bin/bash

mapfile themes <contrib.txt
# All contrib template should only have one entry point.
for theme in ${themes[@]};
do
    echo Compiling $theme documentation...
    cp contrib/$theme/$theme.tex ./$theme.tex
    # build at local dir and use -shell-escape to make minted happy.
    latexmk $@ $theme.tex -shell-escape
    cp $theme.pdf build/$theme.pdf
    echo Compiling $theme preview ...
    sed -e "s|<theme>|$theme|g" src/support/contrib.template.tex > build/contrib.$theme.tex
    latexmk $@ -outdir=build build/contrib.$theme.tex
    echo Converting $theme to png...
    convert -verbose -density 500 -resize '1280' build/contrib.$theme.pdf build/contrib.$theme.png
done