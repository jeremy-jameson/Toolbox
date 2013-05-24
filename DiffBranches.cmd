@echo off

setlocal

REM set DIFFTOOL=Windiff.exe
set DIFFTOOL=C:\NotBackedUp\Public\Toolbox\DiffMerge\DiffMerge.exe

set BRANCH1=%1
set BRANCH2=%2

if ("%BRANCH1%") == ("") set BRANCH1=Main

if ("%BRANCH2%") == ("") set BRANCH2=v3.0

call CopyBranch.cmd "%BRANCH1%" "%BRANCH1%_tmp"

call CopyBranch.cmd "%BRANCH2%" "%BRANCH2%_tmp"

"%DIFFTOOL%" "%BRANCH1%_tmp" "%BRANCH2%_tmp"