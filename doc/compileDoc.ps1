# PowerShell script for 
# Compiling Documentation of SJTUBeamer

Remove-Item -Path tmp/ -Recurse
New-Item tmp -Type directory

# Preview files
$preview = @(
    @('red','','color=red','\institute[School of Mathematical Sciences]{数学科学学院}\titlegraphic{\begin{stampbox}[white]\includegraphics[width=0.3\textwidth]{vi/head.png}\end{stampbox}}'),
    @('redw','aspectratio=169','color=red','\institute[School of Mathematical Sciences]{数学科学学院}\titlegraphic{\begin{stampbox}[white]\includegraphics[width=0.3\textwidth]{vi/head.png}\end{stampbox}}'),
    @('blue','','navigation=subsections','\institute[School of Electronic, \\Information and Electrical Engineering]{电子信息与电气工程学院}\titlegraphic{\begin{stampbox}[white]\includegraphics[width=0.3\textwidth]{vi/head.png}\end{stampbox}}'),
    @('bluew','aspectratio=169','navigation=subsections','\institute[School of Electronic, \\Information and Electrical Engineering]{电子信息与电气工程学院}\titlegraphic{\begin{stampbox}[white]\includegraphics[width=0.3\textwidth]{vi/head.png}\end{stampbox}}'),
    @('beaver','','color=red,gbt=bibtex','\institute[School of Biomedical Engineering]{生物医学工程学院}\usecolortheme{beaver}\logo{\includegraphics{vi/cnlogored.pdf}}\titlegraphic{\begin{stampbox}\includegraphics[width=0.3\textwidth]{vi/head.png}\end{stampbox}}'),
    @('beaverw','aspectratio=169','color=red,gbt=bibtex','\institute[School of Biomedical Engineering]{生物医学工程学院}\usecolortheme{beaver}\logo{\includegraphics{vi/cnlogored.pdf}}\titlegraphic{\begin{stampbox}\includegraphics[width=0.3\textwidth]{vi/head.png}\end{stampbox}}')
)

Copy-Item -Path ../src -Destination tmp/ -Recurse

# If PowerShell version < 7,
# please delete -Parallel parameter.
$preview | ForEach-Object -Parallel {
    # Get main part of the slide.
    $main = (Get-Content ../src/main.tex)
    $main = ($main[26..$main.length] -join "`r`n")
    $source = $_[0] + '.tex'
    $target = $_[0] + '.pdf'
    $file = '\documentclass[' + $_[1] + ']{beamer}\mode<presentation>\usetheme[' + $_[2] + ']{SJTUBeamermin}\addbibresource{ref.bib}' + $_[3] + '\begin{document}' + $main
    $file | Out-File tmp/src/$source
    Set-Location tmp/src
    latexmk -pdf $source -interaction=nonstopmode
    Copy-Item -Path $target -Destination ../../pdf/$target
    Set-Location ../..
} 

# Compile documentation
pdflatex SJTUBeamermintheme.tex -interaction=nonstopmode
pdflatex SJTUBeamermintheme.tex -interaction=nonstopmode

# Compile poster
Set-Location img
pdflatex poster.tex -interaction=nonstopmode

# Compile dev guide
Set-Location ..
latexmk -pdf SJTUBeamermindevguide

Remove-Item -Path tmp/ -Recurse