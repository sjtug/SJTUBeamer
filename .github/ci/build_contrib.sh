# !/bin/bash

themes=$(git diff main --name-only | grep -P 'contrib/[^/]+\/sjtubeamertheme[^/]*\.ltx' | grep -oP '\/[^/]*\/')
# All contrib template should only have one entry point.
for theme in ${themes[@]};
do
    theme=${theme:1:${#theme}-2}
    echo Compiling $theme documentation...
    cp contrib/$theme/$theme.tex ./$theme.tex
    latexmk $@ -outdir=build $theme.tex
    echo Compiling $theme preview ...
    sed -e "s|<theme>|$theme|g" src/doc/contrib.template.tex > build/contrib.$theme.tex
    latexmk $@ -outdir=build build/contrib.$theme.tex
    echo Converting $theme to png...
    convert -verbose -density 500 -resize '1280' build/contrib.$theme.pdf build/contrib.$theme.png
done