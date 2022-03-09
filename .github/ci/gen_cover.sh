#!/bin/bash

set -e

mkdir -p build

# covers
sed -e "s|<options>|red,light|g" src/doc/cover.template.tex > build/cover-red-light.tex
sed -e "s|<options>|red,dark|g" src/doc/cover.template.tex > build/cover-red-dark.tex
sed -e "s|<options>|blue,light|g" src/doc/cover.template.tex > build/cover-blue-light.tex
sed -e "s|<options>|blue,dark|g" src/doc/cover.template.tex > build/cover-blue-dark.tex

# compile covers
latexmk $@ -outdir=build build/cover-*.tex

# copy cover main file with removed last line
cp -f src/doc/cover.tex build/cover.tex
sed -e "s|\\\end{document}||g" src/doc/cover.tex > build/cover.tex

# contrib
for theme in contrib/*;
do
    theme=${theme/contrib\//}
    echo Compiling $theme ...
    cp contrib/$theme/$theme.tex ./$theme.tex
    latexmk $@ $theme.tex
    cp $theme.pdf build/$theme.pdf
    echo \\includepdf{$theme.pdf}>>build/cover.tex
done

echo \\end{document}>>build/cover.tex

# merge covers
latexmk $@ -outdir=build build/cover.tex
