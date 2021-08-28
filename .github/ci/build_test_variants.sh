#!/bin/bash

set -e

rm -rf build
mkdir -p build

# main builds

sed -e "s|usetheme\[.*\]|usetheme\[maxplus,blue\]|g" main.tex > build/build-blue.tex
sed -e "s|usetheme\[.*\]|usetheme\[max,light,red\]|g" main.tex              > build/build-red.tex
sed -e "s|usetheme\[.*\]|usetheme\[min,dark,red\]|g" main.tex              > build/build-min.tex

mainbuilds=(blue red min)

for mainbuild in ${mainbuilds[@]};
do
    regstr="s|contents\/basis|contents\/basis-${mainbuild}|g"
    file=build/build-$mainbuild.tex
    echo $file
    sed -e $regstr $file > $file.tmp
    rm -f $file
    mv $file.tmp $file
done

mainbuilds=(blue red min)
for mainbuild in ${mainbuilds[@]};
do
{
    # eliminate data dependencies
    cp contents/basis.tex contents/basis-$mainbuild.tex
    latexmk $@ -outdir=build build/build-$mainbuild.tex
}
done
wait

echo BUILD COMPLETE.