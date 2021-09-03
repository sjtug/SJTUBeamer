# If you are windows user
# To compile the doc, go through
# this Powershell 7 Script First.

Set-Location ../..

# unpack the dtx files first.
l3build unpack

Copy-Item -Path support -Destination build/unpack/ -Recurse

Set-Location build/unpack

Get-ChildItem unpack/support/tutourial/step*.tex | ForEach-Object -Parallel {
    echo $_
}