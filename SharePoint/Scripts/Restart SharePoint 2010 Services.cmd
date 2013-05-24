@echo off

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