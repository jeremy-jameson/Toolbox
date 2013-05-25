<#
.SYNOPSIS
Gets the list of folders specified in the Path environment variable.

.PARAMETER EnvironmentVariableTarget
Specifies the "scope" to use when querying the Path environment variable
("Process", "Machine", or "User"). Defaults to "Process" if the parameter is
not specified.

.EXAMPLE
.\Get-PathFolders.ps1
C:\Windows\system32\WindowsPowerShell\v1.0\
C:\Windows\system32
C:\Windows
C:\Windows\System32\Wbem
...

Description
-----------
The output from this example lists each folder in the Path environment variable
for the current process.

.EXAMPLE
.\Get-PathFolders.ps1 User
C:\NotBackedUp\Public\Toolbox

Description
-----------
The output from this example assumes one folder
("C:\NotBackedUp\Public\Toolbox") has previously been added to the user's Path
environment variable.
#>
param(
    [string] $EnvironmentVariableTarget = "Process")

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

[string[]] $pathFolders = [Environment]::GetEnvironmentVariable(
    "Path",
    $EnvironmentVariableTarget) -Split ";"

If ($pathFolders -ne $null)
{
    Write-Output $pathFolders
}