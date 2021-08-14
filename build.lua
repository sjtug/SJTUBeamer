#!/usr/bin/env texlua

-- Windows MikTeX still have l3build bug!
-- Use ubuntu to compile.
-- https://github.com/latex3/l3build/issues/185

module           = "sjtubeamermin"

sourcefiledir    = "source"
sourcefiles      = {"*.ins","*.dtx","sjtucnlogo.pdf","sjtuenlogo.pdf"}
installfiles     = {"*.sty","sjtucnlogo.pdf","sjtuenlogo.pdf"}

docfiledir       = "doc"
typesetexe       = "xelatex"
typesetfiles     = {"sjtubeamermintheme.tex","sjtubeamermindevguide.tex"}
typesetdemofiles = {"red.tex","blue.tex"}

testfiledir      = "test"
checkengines     = {"xetex"}
checkopts        = "-interaction=batchmode"

packtdszip       = true -- recommended for "tree" layouts