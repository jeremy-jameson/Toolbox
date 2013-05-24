@echo off

IF NOT EXIST "%ProgramFiles%\Common Files\Microsoft Shared\web server extensions\12" goto RestartSharePoint2010Services

:RestartSharePoint2007Services

@echo Stopping SharePoint 2007 services...

iisreset /stop /noforce

net stop "Windows SharePoint Services Timer"

net stop "Windows SharePoint Services Administration"

net stop "Office SharePoint Server Search"

net stop "Windows SharePoint Services Search"

net stop "Windows SharePoint Services Tracing"

@pause

@echo Starting SharePoint 2007 services...

net start "Windows SharePoint Services Tracing"

net start "Windows SharePoint Services Search"

net start "Office SharePoint Server Search"

net start "Windows SharePoint Services Administration"

net start "Windows SharePoint Services Timer"

iisreset /start

@pause

IF NOT EXIST "%ProgramFiles%\Common Files\Microsoft Shared\web server extensions\14" goto End

:RestartSharePoint2010Services

@echo Stopping SharePoint 2010 services...

iisreset /stop /noforce

net stop "SharePoint 2010 User Code Host"

net stop "SharePoint 2010 Timer"

net stop "SharePoint 2010 Administration"

net stop "SharePoint Server Search 14"

net stop "SharePoint Foundation Search V4"

net stop "SharePoint 2010 Tracing"

@pause

@echo Starting SharePoint 2010 services...

net start "SharePoint 2010 Tracing"

net start "SharePoint Foundation Search V4"

net start "SharePoint Server Search 14"

net start "SharePoint 2010 Administration"

net start "SharePoint 2010 Timer"

net start "SharePoint 2010 User Code Host"

iisreset /start

@pause

:End