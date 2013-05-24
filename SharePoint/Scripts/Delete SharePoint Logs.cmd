@echo off
setlocal

set QUIET_MODE=false

if "%1" == "/Q" set QUIET_MODE=true

set LogFolder=%ProgramFiles%\Common Files\Microsoft Shared\web server extensions\12\LOGS

IF NOT EXIST "%LogFolder%" set LogFolder=%ProgramFiles%\Common Files\Microsoft Shared\web server extensions\14\LOGS

if "%QUIET_MODE%" == "true" goto DeleteSharePointLogs

echo This will delete all of the log files in the following folder:
echo    %LogFolder%
echo Are you sure you want to do this? (Press CTRL+C to exit)
pause

:DeleteSharePointLogs
del /q "%LogFolder%\*.log"