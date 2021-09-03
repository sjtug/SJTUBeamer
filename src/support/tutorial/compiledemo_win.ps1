# If you are windows user
# To compile the doc, go through
# this Powershell 7 Script First.

# l3build has Windows bug on this.

Set-Location ../..

Remove-Item -Path build/unpacked -Recurse

# unpack the dtx files first.
l3build unpack

Copy-Item -Path support -Destination build/unpacked/ -Recurse

Copy-Item -Path support/* -Destination build/

Set-Location build/unpacked

# Parallel is only available for PowerShell 7
Get-ChildItem support/tutorial/step*.tex | ForEach-Object -Parallel {
    latexmk $_ -xelatex -interaction=nonstopmode
}

Copy-Item -Path step*.pdf -Destination ../../support/tutorial -Recurse

Set-Location ../../support/tutorial