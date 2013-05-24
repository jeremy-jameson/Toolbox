@echo off

setlocal

set BRANCH1=%1
set BRANCH2=%2

if ("%BRANCH1%") == ("") set BRANCH1=Main

if ("%BRANCH2%") == ("") set BRANCH2="%BRANCH1%_tmp"

robocopy "%BRANCH1%" "%BRANCH2%" /E /MIR /XD bin obj TestResults /XF *.scc *.suo *.user *.vspscc
