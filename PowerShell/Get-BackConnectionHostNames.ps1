<#PSScriptInfo

.VERSION 1.0.0

.GUID e522551c-8289-4524-b974-720d138137ec

.AUTHOR jeremy-jameson

.COMPANYNAME 

.COPYRIGHT 

.TAGS IIS 

.LICENSEURI 

.PROJECTURI https://github.com/jeremy-jameson/Toolbox

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES


#>

<#
.SYNOPSIS
Gets the list of host names specified in the BackConnectionHostNames registry
value.

.DESCRIPTION
The BackConnectionHostNames registry value is used to bypass the loopback
security check for specific host names.

.LINK
http://support.microsoft.com/kb/896861

.EXAMPLE
.\Get-BackConnectionHostNames.ps1
fabrikam-local
www-local.fabrikam.com

Description
-----------
The output from this example assumes two host names ("fabrikam-local" and
"www-local.fabrikam.com") have previously been added to the
BackConnectionHostNames registry value .
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

[string] $registryPath = "HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0"

$registryKey = Get-Item -Path $registryPath

$backConnectionHostNames = $registryKey.GetValue("BackConnectionHostNames")

If ($backConnectionHostNames -ne $null)
{
    $backConnectionHostNames | Write-Output
}