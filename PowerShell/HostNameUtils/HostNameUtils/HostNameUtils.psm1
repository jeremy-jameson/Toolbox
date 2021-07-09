$scripts = "$PSScriptRoot\*.ps1"
Get-ChildItem $scripts | ForEach-Object { . "$_" }
