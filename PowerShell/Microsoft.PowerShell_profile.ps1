$Host.PrivateData.VerboseForegroundColor = "DarkGray"
$Host.PrivateData.DebugForegroundColor = "Cyan"

Set-Alias `
    -Name code `
    -Value "C:\Program Files\Microsoft VS Code\Code.exe"

Set-Alias `
    -Name fciv `
    -Value C:\NotBackedUp\Public\Toolbox\FCIV\fciv.exe

If ($env:PROCESSOR_ARCHITECTURE -eq "AMD64") {
    Set-Alias `
        -Name sgdm `
        -Value C:\NotBackedUp\Public\Toolbox\DiffMerge\x64\sgdm.exe
}
Else {
    Set-Alias `
        -Name sgdm `
        -Value C:\NotBackedUp\Public\Toolbox\DiffMerge\x86\sgdm.exe
}

Function desktop {
    [String] $regPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer'

    [String] $desktopPath = Get-ItemProperty `
        -Path "$regPath\User Shell Folders" `
        -Name Desktop |
    select -ExpandProperty Desktop

    If ([String]::IsNullOrEmpty($desktopPath) -eq $true) {
        $desktopPath = Get-ItemProperty `
            -Path "$regPath\Shell Folders" `
            -Name Desktop |
        select -ExpandProperty Desktop
    }

    If ([String]::IsNullOrEmpty($desktopPath) -eq $true) {
        Throw "Unable to determine Desktop path."
    }

    Push-Location $desktopPath
}

Function temp { Push-Location C:\NotBackedUp\Temp }

Function toolbox { Push-Location C:\NotBackedUp\Public\Toolbox }

Function Enable-SharePointCmdlets {
    If ((Get-PSSnapin Microsoft.SharePoint.PowerShell `
                -ErrorAction SilentlyContinue) -eq $null) {
        Write-Debug "Adding snapin (Microsoft.SharePoint.PowerShell)..."

        $ver = $host | select version

        If ($ver.Version.Major -gt 1) {
            $Host.Runspace.ThreadOptions = "ReuseThread"
        }

        Add-PSSnapin Microsoft.SharePoint.PowerShell
    }
}


# SIG # Begin signature block
# MIIO3AYJKoZIhvcNAQcCoIIOzTCCDskCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUPoqEtbA5SEn3R2AG4KP1pMLx
# j22gggwAMIIFrDCCBJSgAwIBAgITZAAADIvxpAQFTv7wVgABAAAMizANBgkqhkiG
# 9w0BAQsFADCBjDETMBEGCgmSJomT8ixkARkWA2NvbTEhMB8GCgmSJomT8ixkARkW
# EXRlY2hub2xvZ3l0b29sYm94MRQwEgYKCZImiZPyLGQBGRYEY29ycDE8MDoGA1UE
# AxMzVGVjaG5vbG9neSBUb29sYm94IElzc3VpbmcgQ2VydGlmaWNhdGUgQXV0aG9y
# aXR5IDAxMB4XDTE5MTIwNjExNTAxNloXDTIwMTIwNTExNTAxNlowgY0xEzARBgoJ
# kiaJk/IsZAEZFgNjb20xITAfBgoJkiaJk/IsZAEZFhF0ZWNobm9sb2d5dG9vbGJv
# eDEUMBIGCgmSJomT8ixkARkWBGNvcnAxFDASBgNVBAsTC0RldmVsb3BtZW50MQ4w
# DAYDVQQLEwVVc2VyczEXMBUGA1UEAxMOSmVyZW15IEphbWVzb24wggEiMA0GCSqG
# SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDq/YafGWtyuWqE66TJ2rJcN4icQMma9L8q
# JsmDAf7mFrHsT3Ti3UxzFfUe/SvlPC8sYRSD1PWSjh7vO6tKh6AZTfvxA2wat8Z+
# Gu33azGW5Ci9ftg9fMLVnn9/HMc+Q53b7pF7qJCO7MsTBxtjI2ltM+3YnjJbXBiR
# vhV6Ua9r+3g/660XJXTtmUfUbkGwq6Db+nJBZCDYh3Zop9a+SKIdlI308JKCh8x7
# bx+fT1jYPsjQi2RRrJSWMLoJfEbKcHk38Gw0MHgnhYQfHQpsKZz9lBPoNPpRI6Ov
# QTo5geb4yV0zAAks12dj8Bdnyl8W+CehAYaBI51GjpYTzHYNoCiVAgMBAAGjggIC
# MIIB/jAOBgNVHQ8BAf8EBAMCB4AwPAYJKwYBBAGCNxUHBC8wLQYlKwYBBAGCNxUI
# huWbOYSWnVGB5YEB8tNbhK7kJniG4bMmhZyJeAIBZAIBAjAdBgNVHQ4EFgQUYLDV
# YbG+PnfeaxCdxSxn69c3EUAwHwYDVR0jBBgwFoAUP5/e9Uwt/WW6L/g9PT91jWUE
# DcIwdwYDVR0fBHAwbjBsoGqgaIZmaHR0cDovL3BraS50ZWNobm9sb2d5dG9vbGJv
# eC5jb20vY3JsL1RlY2hub2xvZ3klMjBUb29sYm94JTIwSXNzdWluZyUyMENlcnRp
# ZmljYXRlJTIwQXV0aG9yaXR5JTIwMDEuY3JsMIGHBggrBgEFBQcBAQR7MHkwdwYI
# KwYBBQUHMAKGa2h0dHA6Ly9wa2kudGVjaG5vbG9neXRvb2xib3guY29tL2NlcnRz
# L1RlY2hub2xvZ3klMjBUb29sYm94JTIwSXNzdWluZyUyMENlcnRpZmljYXRlJTIw
# QXV0aG9yaXR5JTIwMDEoMSkuY3J0MBMGA1UdJQQMMAoGCCsGAQUFBwMDMBsGCSsG
# AQQBgjcVCgQOMAwwCgYIKwYBBQUHAwMwOQYDVR0RBDIwMKAuBgorBgEEAYI3FAID
# oCAMHmpqYW1lc29uQHRlY2hub2xvZ3l0b29sYm94LmNvbTANBgkqhkiG9w0BAQsF
# AAOCAQEAgSdjvu6Fz3uzeMa/wYOttKPFGVEmoZr0H7h4pPE5JmfHyD5Wq0GUzHEs
# UoO6bCcQrxue95gZCxKXtgDjHHS0rRhlMqBHRRRR6HbdPRfJFxTUrYAyTo1wkpWc
# eTRagxu0DJpFVCCrw9H9tHpxvoEmJR7PgoIe7oBj47onu1mHK021+jq40etWOcLn
# +tIRTJ9HbNgZCcLX4h7YTiFQnCidzENsrK91aWw4tMsZSdpif1Jc5HdqUZD0TPGO
# YQZgYSCd9wD+kuMtx62YPaZ5jN8DQ98sLwnj0YTJlCpRXQrU7Y+YxJucFGMXfpIt
# RmDp4XaIry7Bh4CaWKxEDVrEQBIn3jCCBkwwggQ0oAMCAQICE2cAAAAG+pBAW53Q
# oyMAAwAAAAYwDQYJKoZIhvcNAQELBQAwODE2MDQGA1UEAxMtVGVjaG5vbG9neSBU
# b29sYm94IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5MB4XDTE5MDUxNDE3NTc1
# N1oXDTI5MDUxNDE4MDc1N1owgYwxEzARBgoJkiaJk/IsZAEZFgNjb20xITAfBgoJ
# kiaJk/IsZAEZFhF0ZWNobm9sb2d5dG9vbGJveDEUMBIGCgmSJomT8ixkARkWBGNv
# cnAxPDA6BgNVBAMTM1RlY2hub2xvZ3kgVG9vbGJveCBJc3N1aW5nIENlcnRpZmlj
# YXRlIEF1dGhvcml0eSAwMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
# ANvon3OB43xiKSTYZp5AhDY22pJZP54lAlbzvZDMB9BAufPmcZWILN0VI782yYXM
# r0rCY2bQActZK3n9TuPcPDk2FsiTFNNMn6+b+UE8tBcBOt+0x9BVOe/qeO+4rqNE
# eENTCcVbKxaVAahtfqIH3Vl20b5CQ/O0w9iiWgBFQ8MckiIv6C+uvud19+Skn6M8
# b5zNxmuPxtaJOUY/1/WUjMHIezAEg6ldzWl0940BQQp9wn1fECZKaE2vtqqvBZIg
# bcFmCZxJKHxXIM3nMfYaZLJulcLMORKwzKnk6Ar9THWVNfJ/idExsAzpznwV6ExI
# 8XIxltIjRjoujdWaYva9s6sCAwEAAaOCAfgwggH0MBAGCSsGAQQBgjcVAQQDAgEB
# MCMGCSsGAQQBgjcVAgQWBBTcoBiv/8PNvbVTVzxHKDXULCNbPzAdBgNVHQ4EFgQU
# P5/e9Uwt/WW6L/g9PT91jWUEDcIwTQYDVR0gBEYwRDBCBgsrBgEEAYLNAQEBATAz
# MDEGCCsGAQUFBwIBFiVodHRwOi8vcGtpLnRlY2hub2xvZ3l0b29sYm94LmNvbS9j
# cHMAMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsGA1UdDwQEAwIBhjASBgNV
# HRMBAf8ECDAGAQH/AgEAMB8GA1UdIwQYMBaAFL5GNjsOt0Z9JYRtW7/fkw5emo74
# MG8GA1UdHwRoMGYwZKBioGCGXmh0dHA6Ly9wa2kudGVjaG5vbG9neXRvb2xib3gu
# Y29tL2NybC9UZWNobm9sb2d5JTIwVG9vbGJveCUyMFJvb3QlMjBDZXJ0aWZpY2F0
# ZSUyMEF1dGhvcml0eS5jcmwwfwYIKwYBBQUHAQEEczBxMG8GCCsGAQUFBzAChmNo
# dHRwOi8vcGtpLnRlY2hub2xvZ3l0b29sYm94LmNvbS9jZXJ0cy9UZWNobm9sb2d5
# JTIwVG9vbGJveCUyMFJvb3QlMjBDZXJ0aWZpY2F0ZSUyMEF1dGhvcml0eSgzKS5j
# cnQwDQYJKoZIhvcNAQELBQADggIBAB/rwg3ZQEmOhrwcANx3yEZjFJwIpdeOeydK
# uYndfQyDGFLNADBjKaJOsv9buAujjWwU72BXssDWB85687Z4LS3aoyRgGcwVRjU2
# tYvC7YnJMUnGJ5QMsuOw2ZCgfgTpAIkWgJ7O1ByTn6h7xXsm5mktS7yxczAixP8R
# weqDL5q/0r4nDgl2Oup31TYu99x7KmREWmXlj7PEJ1+npYoFI532WCzwZFJWQMnE
# KzaIE3aEDYdqr+1vKp+AuCq1GYkK8Mf4+RZqtiAYQ1aPTI/yzGQ+YtI/fmq34Y3M
# 8E9v/TgNbAFOvHbWsm1UMisGgtP9aloYOEGXQQLE/o80X0bwy0CRcft4btDNHVmD
# 4DLnEuJ5biWPfXpNU6YQxHwxgMn350mfsnH/4D5S+cNt0c+Vj7FNySUW23BjOn/W
# cham8cTw9lRE3V2h//sDTFYchELy/h35Vn/A7ROPZqJk1x/W1YPHLx2/D5/+RqWW
# SP6S7Nh7jC4OGIcCd8OsqTgFRax0tP+tqZFO1alPZMk+/RadK50h6hedlOqbhGHH
# w4iaE89wffagkcn+tTUIViRJyfrky2fprAjFUM7USCUfNnFCKCwb54iRftNQaM1E
# /Mo58XBN20LETCJPqZtxDntzn2cGjRrtFRNm0D6FDa57L/1th0xmRhPfCj36cqhQ
# yF8Nav57MYICRjCCAkICAQEwgaQwgYwxEzARBgoJkiaJk/IsZAEZFgNjb20xITAf
# BgoJkiaJk/IsZAEZFhF0ZWNobm9sb2d5dG9vbGJveDEUMBIGCgmSJomT8ixkARkW
# BGNvcnAxPDA6BgNVBAMTM1RlY2hub2xvZ3kgVG9vbGJveCBJc3N1aW5nIENlcnRp
# ZmljYXRlIEF1dGhvcml0eSAwMQITZAAADIvxpAQFTv7wVgABAAAMizAJBgUrDgMC
# GgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYK
# KwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG
# 9w0BCQQxFgQUUqeZG5Ms8VhOCPvmK4q0QoBYAMYwDQYJKoZIhvcNAQEBBQAEggEA
# CpDGlob+GnnggANC50AhRrRqftMH12B4E+AMoaC/ks2XM27QFWSiTmANG8WHH+BN
# VgTk52ZpMIl7Om2BrShyulhlRJ4VkgvIA93nmT/uSFUzEXZuOMtU3ljCMuU5kPUT
# UdE87VAv8DahQ9ONEenArfj1LGlHv2v83vFKmICczdRNHHjfCkiQ9YfcXqMusvrF
# YwPL5fGnwxnmgAHXGhMqK6fmKjvQVoozZoyooI93JAjMN8UUKJViuFU2CLV/38XE
# 9eR5HB6tVx2YbVuv9WHpk0MXQeBCilGp5GpAn32CTwVbCJmG6dvuxmMvF0Uqu89U
# pHfDmap85GGDKu56vgwKGg==
# SIG # End signature block
