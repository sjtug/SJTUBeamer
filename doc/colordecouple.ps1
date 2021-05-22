# PowerShell script for 
# Compiling Colortheme Decoupler of SJTUBeamer

Remove-Item -Path color/ -Recurse
New-Item color -Type directory

Remove-Item -Path tmp/ -Recurse
New-Item tmp -Type directory

$colortheme = @(
    'albatross',
    'beaver',
    'beetle',
    'crane',
    # 'default',
    'dolphin',
    'dove',
    'fly',
    'lily',
    'monarca',
    'orchid',
    'rose',
    'seagull',
    'seahorse',
    'sidebartab',
    'spruce',
    'structure',
    'whale'
)

Copy-Item -Path ../src -Destination tmp/ -Recurse

Set-Location tmp/src
# latexmk -pdf main.tex -interaction=nonstopmode

# If PowerShell version < 7,
# please delete -Parallel parameter.
$colortheme | ForEach-Object -Parallel {
    # Get main part of the slide.
    $main = (Get-Content main.tex)
    $main = ($main[16..$main.length] -join "`r`n")
    $theme = $_
    $mode = @(
        @('RW','color=red'),
        @('BW','color=blue'),
        @('RR','color=red,logo=vi/cnlogored.pdf'),
        @('BR','color=blue,logo=vi/cnlogored.pdf')
    )
    $source = $theme + $mode[0][0] + '.tex'
    $target = $theme + $mode[0][0] + '.pdf'
    $file = '\documentclass{beamer}\mode<presentation>\usetheme[' + $mode[0][1] + ']{SJTUBeamermin}\usecolortheme{' + $theme + '}\institute[School of Electronic, \\Information and Electrical Engineering]{电子信息与电气工程学院}' + $main
    $file | Out-File $source
    pdflatex $source -interaction=nonstopmode   # Save time
    Copy-Item -Path $target -Destination ../../color/$target

    $source = $theme + $mode[1][0] + '.tex'
    $target = $theme + $mode[1][0] + '.pdf'
    $file = '\documentclass{beamer}\mode<presentation>\usetheme[' + $mode[1][1] + ']{SJTUBeamermin}\usecolortheme{' + $theme + '}\institute[School of Electronic, \\Information and Electrical Engineering]{电子信息与电气工程学院}' + $main
    $file | Out-File $source
    pdflatex $source -interaction=nonstopmode   # Save time
    Copy-Item -Path $target -Destination ../../color/$target

    $source = $theme + $mode[2][0] + '.tex'
    $target = $theme + $mode[2][0] + '.pdf'
    $file = '\documentclass{beamer}\mode<presentation>\usetheme[' + $mode[2][1] + ']{SJTUBeamermin}\usecolortheme{' + $theme + '}\institute[School of Electronic, \\Information and Electrical Engineering]{电子信息与电气工程学院}' + $main
    $file | Out-File $source
    pdflatex $source -interaction=nonstopmode   # Save time
    Copy-Item -Path $target -Destination ../../color/$target

    $source = $theme + $mode[3][0] + '.tex'
    $target = $theme + $mode[3][0] + '.pdf'
    $file = '\documentclass{beamer}\mode<presentation>\usetheme[' + $mode[3][1] + ']{SJTUBeamermin}\usecolortheme{' + $theme + '}\institute[School of Electronic, \\Information and Electrical Engineering]{电子信息与电气工程学院}' + $main
    $file | Out-File $source
    pdflatex $source -interaction=nonstopmode   # Save time
    Copy-Item -Path $target -Destination ../../color/$target
} 

Set-Location ../..
Remove-Item -Path tmp/ -Recurse