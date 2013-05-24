$ErrorActionPreference = "Stop"

Import-Module Pscx -EA 0

function ExtractLogFiles(
    [string] $httpLogPath)
{
    If ([string]::IsNullOrEmpty($httpLogPath) -eq $true)
    {
        Throw "The log path must be specified."    
    }
    
    [string] $httpLogArchive = $httpLogPath + "\Archive"
    
    If ((Test-Path $httpLogArchive) -eq $false)
    {
        Write-Host "Creating archive folder for compressed log files..."
        New-Item -ItemType directory -Path $httpLogArchive | Out-Null
    }
    
    Write-Host "Extracting compressed log files..."
    
    Get-ChildItem $httpLogPath -Filter "*.zip" |
        ForEach-Object {
            Expand-Archive $_ -OutputPath $httpLogPath
            
            Move-Item $_.FullName $httpLogArchive
        }
}

function ImportLogFiles(
    [string] $httpLogPath)
{
    If ([string]::IsNullOrEmpty($httpLogPath) -eq $true)
    {
        Throw "The log path must be specified."    
    }

    [string] $logParser = "${env:ProgramFiles(x86)}" `
        + "\Log Parser 2.2\LogParser.exe"

    [string] $query = `
        [string] $query = `
        "SELECT" `
            + " LogFilename" `
            + ", RowNumber" `
            + ", TO_TIMESTAMP(date, time) AS EntryTime" `
            + ", s-sitename AS SiteName" `
            + ", s-computername AS ServerName" `
            + ", s-ip AS ServerIpAddress" `
            + ", cs-method AS Method" `
            + ", cs-uri-stem AS UriStem" `
            + ", cs-uri-query AS UriQuery" `
            + ", s-port AS Port" `
            + ", cs-username AS Username" `
            + ", c-ip AS ClientIpAddress" `
            + ", cs-version AS HttpVersion" `
            + ", cs(User-Agent) AS UserAgent" `
            + ", cs(Cookie) AS Cookie" `
            + ", cs(Referer) AS Referrer" `
            + ", cs-host AS Hostname" `
            + ", sc-status AS HttpStatus" `
            + ", sc-substatus AS HttpSubstatus" `
            + ", sc-win32-status AS Win32Status" `
            + ", sc-bytes AS BytesFromServerToClient" `
            + ", cs-bytes AS BytesFromClientToServer" `
            + ", time-taken AS TimeTaken" `
        + " INTO WebsiteLog" `
        + " FROM $httpLogPath\*.log"
        
    [string] $connectionString = "Driver={SQL Server Native Client 10.0};" `
        + "Server=BEAST;Database=CaelumDW;Trusted_Connection=yes;"
    
    [string[]] $parameters = @()
    
    $parameters += $query
    $parameters += "-i:W3C"
    $parameters += "-o:SQL"
    $parameters += "-oConnString:$connectionString"
    
    Write-Debug "Parameters: $parameters"
    
    Write-Host "Importing log files to database..."
    & $logParser $parameters
}

function RemoveLogFiles(
    [string] $httpLogPath)
{
    If ([string]::IsNullOrEmpty($httpLogPath) -eq $true)
    {
        Throw "The log path must be specified."    
    }
    
    Write-Host "Removing log files..."    
    Remove-Item ($httpLogPath + "\*.log")
}
    
function Main
{
    [string] $httpLogPath = "C:\inetpub\wwwroot\www.technologytoolbox.com\httplog"

    ExtractLogFiles $httpLogPath

    ImportLogFiles $httpLogPath
    
    RemoveLogFiles $httpLogPath
        
    Write-Host -Fore Green "Successfully imported log files."
}

Main