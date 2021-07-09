$ErrorActionPreference = 'Stop'

$psRepo = Read-Host 'Enter Name of Powershell repo (leave empty to use PSGallery)'
$apiKey = Read-Host 'Enter NuGet Api Key'
if ([string]::IsNullOrWhiteSpace($apiKey)) {
    return
}
if ([string]::IsNullOrWhiteSpace($psRepo)) {
    $psRepo = 'PSGallery'
}
$params = @{
    Repository  = $psRepo
    NuGetApiKey = $apiKey
    Path = "$PSScriptRoot\HostNameUtils"
}
Publish-Module @params
