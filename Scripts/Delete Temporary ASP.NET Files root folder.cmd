@echo off

setlocal

set ROOT_FOLDER=%SystemRoot%\Microsoft.NET\Framework\v2.0.50727\Temporary ASP.NET Files\root

if not exist "%ROOT_FOLDER%" goto RootFolderDoesNotExist

echo Stopping IIS...
iisreset /stop

echo Removing Temporary ASP.NET Files root folder...
rmdir /Q /S "%SystemRoot%\Microsoft.NET\Framework\v2.0.50727\Temporary ASP.NET Files\root"

echo Starting IIS...
iisreset /start

exit

:RootFolderDoesNotExist
echo Root folder does not exist: "%ROOT_FOLDER%"
pause
