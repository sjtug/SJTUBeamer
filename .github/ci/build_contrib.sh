themes=$(git diff main --name-only | grep -P 'contrib/[^/]+\/sjtubeamertheme[^/]*\.ltx' | grep -oP '\/[^/]*\/')
# All contrib template should only have one entry point.
for theme in ${themes[@]};
do
    theme=${theme:1:${#theme}-2}
    echo compiling $theme ...
    cp contrib/$theme/$theme.tex ./$theme.tex
    latexmk $@ -outdir=build $theme.tex
done