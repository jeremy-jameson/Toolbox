@echo off

@echo Stopping services...

iisreset /stop /noforce

net stop "Windows SharePoint Services Timer"

net stop "Windows SharePoint Services Administration"

net stop "Office SharePoint Server Search"

net stop "Windows SharePoint Services Search"

net stop "Windows SharePoint Services Tracing"

@pause

@echo Starting services...

net start "Windows SharePoint Services Tracing"

net start "Windows SharePoint Services Search"

net start "Office SharePoint Server Search"

net start "Windows SharePoint Services Administration"

net start "Windows SharePoint Services Timer"

iisreset /start

@pause