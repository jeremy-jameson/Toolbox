$Host.PrivateData.VerboseForegroundColor = "DarkGray"
$Host.PrivateData.DebugForegroundColor = "Magenta"

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

# Ensure the following commands have been executed from an elevated prompt
# (and leave them commented out here)
#
#Install-Module posh-git -Scope AllUsers
#Install-Module oh-my-posh -Scope AllUsers
#
# This avoids lengthy delays when loading the PowerShell profile
#
# Reference:
#
# https://github.com/JanDeDobbeleer/oh-my-posh2/issues/251#issuecomment-654150622

# Only set the custom prompt when running in Windows Terminal to avoid issues
# (for example, slight differences in the color scheme used for Cmder windows
# make text difficult to read)

If ($env:WT_SESSION) {
    Set-PoshPrompt -Theme C:\NotBackedUp\GitHub\jeremy-jameson\Toolbox\oh-my-posh\jeremy-jameson.omp.json
    $env:POSH_SESSION_DEFAULT_USER = 'jjameson'
}
# SIG # Begin signature block
# MIIPCwYJKoZIhvcNAQcCoIIO/DCCDvgCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUFPzNIMjRyM9xCuYdTxwLfA+4
# 4kygggwvMIIF2zCCBMOgAwIBAgITZAAADoThAI2La6lyLQABAAAOhDANBgkqhkiG
# 9w0BAQsFADCBjDETMBEGCgmSJomT8ixkARkWA2NvbTEhMB8GCgmSJomT8ixkARkW
# EXRlY2hub2xvZ3l0b29sYm94MRQwEgYKCZImiZPyLGQBGRYEY29ycDE8MDoGA1UE
# AxMzVGVjaG5vbG9neSBUb29sYm94IElzc3VpbmcgQ2VydGlmaWNhdGUgQXV0aG9y
# aXR5IDAxMB4XDTIxMDUxNDE5NTA0MFoXDTIyMDUxNDE5NTA0MFowgbwxEzARBgoJ
# kiaJk/IsZAEZFgNjb20xITAfBgoJkiaJk/IsZAEZFhF0ZWNobm9sb2d5dG9vbGJv
# eDEUMBIGCgmSJomT8ixkARkWBGNvcnAxFDASBgNVBAsTC0RldmVsb3BtZW50MQ4w
# DAYDVQQLEwVVc2VyczEXMBUGA1UEAxMOSmVyZW15IEphbWVzb24xLTArBgkqhkiG
# 9w0BCQEWHmpqYW1lc29uQHRlY2hub2xvZ3l0b29sYm94LmNvbTCCASIwDQYJKoZI
# hvcNAQEBBQADggEPADCCAQoCggEBAMsApiTps4fPRW25YpGZY9d/h03maKMLevDk
# 7vm8aYDqoxsVPj696ljQkU0ScEuW7BccGuOmswtJgjGQfAk2e1wt25kmuNQE9JIw
# 99seYtbfEa9iZgyIBSCd6MCaavfaD6rqemiTqW/yiGPoByfQ2AmUgN1EoGLgkBBr
# yu9bGmy1xAeaT3+yRBZ1o127nmcYZHgT/Bg8tIvSJS8j9mvLI+q+RXH3q/w0dW1H
# Bb/qy5CQsxtc8emgrv5tjjs7HMY4ZuyyUviqLdXO3YGFUA3yb6CsCFRbX7Nlm2xW
# 11LHFRqGNPOZtP6aBNAOZU+ymJvxlWNyxfCbgW6zsJeS4e2Qlq0CAwEAAaOCAgIw
# ggH+MDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIblmzmElp1RgeWBAfLTW4Su
# 5CZ4h/ibKIOa4FsCAWQCAQMwEwYDVR0lBAwwCgYIKwYBBQUHAwMwDgYDVR0PAQH/
# BAQDAgeAMBsGCSsGAQQBgjcVCgQOMAwwCgYIKwYBBQUHAwMwHQYDVR0OBBYEFKIa
# G5vEJYXerx2scP4alOgu/Pr9MB8GA1UdIwQYMBaAFD+f3vVMLf1lui/4PT0/dY1l
# BA3CMHcGA1UdHwRwMG4wbKBqoGiGZmh0dHA6Ly9wa2kudGVjaG5vbG9neXRvb2xi
# b3guY29tL2NybC9UZWNobm9sb2d5JTIwVG9vbGJveCUyMElzc3VpbmclMjBDZXJ0
# aWZpY2F0ZSUyMEF1dGhvcml0eSUyMDAxLmNybDCBhwYIKwYBBQUHAQEEezB5MHcG
# CCsGAQUFBzAChmtodHRwOi8vcGtpLnRlY2hub2xvZ3l0b29sYm94LmNvbS9jZXJ0
# cy9UZWNobm9sb2d5JTIwVG9vbGJveCUyMElzc3VpbmclMjBDZXJ0aWZpY2F0ZSUy
# MEF1dGhvcml0eSUyMDAxKDEpLmNydDA5BgNVHREEMjAwoC4GCisGAQQBgjcUAgOg
# IAweamphbWVzb25AdGVjaG5vbG9neXRvb2xib3guY29tMA0GCSqGSIb3DQEBCwUA
# A4IBAQDOPyFw/yAksm6H6LjqiFHNjsK2QppyR3WOJwBLJWmYnW2HrXyFbwgRIba5
# EvjFLbZ3ymx2mcLTcSQ96cWpUumQp/15iIDiFCbRkedRrA0NWHKY0MtB8/o2zGAq
# z/yrLXsQ4brPO7wB0Nx3oe4am00+LBtsXD2oVpb0upxVHnEogPALg09xfV1UH+tE
# dLk18Zsq13XgSfcWkZKbKrEK/zi+qIL3pQ6i3lXD1SRH+zFUr1s5ZYyQnh+CssKR
# eGLL2qdnTQoihtGlwCb6teOoaOasTXhWp6O1EKYIxlHtmkoO5sCfREhbyX3CA9WN
# H1e8RsNsVOn51gEdbIMQOmBvotYyMIIGTDCCBDSgAwIBAgITZwAAAAb6kEBbndCj
# IwADAAAABjANBgkqhkiG9w0BAQsFADA4MTYwNAYDVQQDEy1UZWNobm9sb2d5IFRv
# b2xib3ggUm9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwHhcNMTkwNTE0MTc1NzU3
# WhcNMjkwNTE0MTgwNzU3WjCBjDETMBEGCgmSJomT8ixkARkWA2NvbTEhMB8GCgmS
# JomT8ixkARkWEXRlY2hub2xvZ3l0b29sYm94MRQwEgYKCZImiZPyLGQBGRYEY29y
# cDE8MDoGA1UEAxMzVGVjaG5vbG9neSBUb29sYm94IElzc3VpbmcgQ2VydGlmaWNh
# dGUgQXV0aG9yaXR5IDAxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
# 2+ifc4HjfGIpJNhmnkCENjbaklk/niUCVvO9kMwH0EC58+ZxlYgs3RUjvzbJhcyv
# SsJjZtABy1kref1O49w8OTYWyJMU00yfr5v5QTy0FwE637TH0FU57+p477iuo0R4
# Q1MJxVsrFpUBqG1+ogfdWXbRvkJD87TD2KJaAEVDwxySIi/oL66+53X35KSfozxv
# nM3Ga4/G1ok5Rj/X9ZSMwch7MASDqV3NaXT3jQFBCn3CfV8QJkpoTa+2qq8FkiBt
# wWYJnEkofFcgzecx9hpksm6Vwsw5ErDMqeToCv1MdZU18n+J0TGwDOnOfBXoTEjx
# cjGW0iNGOi6N1Zpi9r2zqwIDAQABo4IB+DCCAfQwEAYJKwYBBAGCNxUBBAMCAQEw
# IwYJKwYBBAGCNxUCBBYEFNygGK//w829tVNXPEcoNdQsI1s/MB0GA1UdDgQWBBQ/
# n971TC39Zbov+D09P3WNZQQNwjBNBgNVHSAERjBEMEIGCysGAQQBgs0BAQEBMDMw
# MQYIKwYBBQUHAgEWJWh0dHA6Ly9wa2kudGVjaG5vbG9neXRvb2xib3guY29tL2Nw
# cwAwGQYJKwYBBAGCNxQCBAweCgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMBIGA1Ud
# EwEB/wQIMAYBAf8CAQAwHwYDVR0jBBgwFoAUvkY2Ow63Rn0lhG1bv9+TDl6ajvgw
# bwYDVR0fBGgwZjBkoGKgYIZeaHR0cDovL3BraS50ZWNobm9sb2d5dG9vbGJveC5j
# b20vY3JsL1RlY2hub2xvZ3klMjBUb29sYm94JTIwUm9vdCUyMENlcnRpZmljYXRl
# JTIwQXV0aG9yaXR5LmNybDB/BggrBgEFBQcBAQRzMHEwbwYIKwYBBQUHMAKGY2h0
# dHA6Ly9wa2kudGVjaG5vbG9neXRvb2xib3guY29tL2NlcnRzL1RlY2hub2xvZ3kl
# MjBUb29sYm94JTIwUm9vdCUyMENlcnRpZmljYXRlJTIwQXV0aG9yaXR5KDMpLmNy
# dDANBgkqhkiG9w0BAQsFAAOCAgEAH+vCDdlASY6GvBwA3HfIRmMUnAil1457J0q5
# id19DIMYUs0AMGMpok6y/1u4C6ONbBTvYFeywNYHznrztngtLdqjJGAZzBVGNTa1
# i8LtickxScYnlAyy47DZkKB+BOkAiRaAns7UHJOfqHvFeybmaS1LvLFzMCLE/xHB
# 6oMvmr/SvicOCXY66nfVNi733HsqZERaZeWPs8QnX6eligUjnfZYLPBkUlZAycQr
# NogTdoQNh2qv7W8qn4C4KrUZiQrwx/j5Fmq2IBhDVo9Mj/LMZD5i0j9+arfhjczw
# T2/9OA1sAU68dtaybVQyKwaC0/1qWhg4QZdBAsT+jzRfRvDLQJFx+3hu0M0dWYPg
# MucS4nluJY99ek1TphDEfDGAyffnSZ+ycf/gPlL5w23Rz5WPsU3JJRbbcGM6f9Zy
# FqbxxPD2VETdXaH/+wNMVhyEQvL+HflWf8DtE49momTXH9bVg8cvHb8Pn/5GpZZI
# /pLs2HuMLg4YhwJ3w6ypOAVFrHS0/62pkU7VqU9kyT79Fp0rnSHqF52U6puEYcfD
# iJoTz3B99qCRyf61NQhWJEnJ+uTLZ+msCMVQztRIJR82cUIoLBvniJF+01BozUT8
# yjnxcE3bQsRMIk+pm3EOe3OfZwaNGu0VE2bQPoUNrnsv/W2HTGZGE98KPfpyqFDI
# Xw1q/nsxggJGMIICQgIBATCBpDCBjDETMBEGCgmSJomT8ixkARkWA2NvbTEhMB8G
# CgmSJomT8ixkARkWEXRlY2hub2xvZ3l0b29sYm94MRQwEgYKCZImiZPyLGQBGRYE
# Y29ycDE8MDoGA1UEAxMzVGVjaG5vbG9neSBUb29sYm94IElzc3VpbmcgQ2VydGlm
# aWNhdGUgQXV0aG9yaXR5IDAxAhNkAAAOhOEAjYtrqXItAAEAAA6EMAkGBSsOAwIa
# BQCgeDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgor
# BgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3
# DQEJBDEWBBTgcPO7z0xIIttbUy47ekQDuB+ezTANBgkqhkiG9w0BAQEFAASCAQAh
# n0+SUF+dNbli/+oENlqFT9SriPNkY6pseuN8CejeLbdweGaFo3DhlJJRP7kdWJs+
# Kq2FePLYgJ/SGBkvZjLJ7bvm/+XzhweeLmgk3ymZ+VGDb4FKsmaFoxVjladVElAJ
# ZPPtFgodiN2Or44JEFZIRNxNCP62xyNVYKO/XGpS1shd3KgbhYlxJX5qsxteCx2b
# mIB07lv6DLW7kJ+tijrOFLK74yxYR9xhhz4D4kt9ZqZzIwYb8huzi/iT5JeSRy2/
# hFEqftBO/24nvMluTvS2fHbX5NDx0Fr16H+IUcQlV4hb8MwTdgLhLqEKDviAZ79C
# 6kyDolqBbE1zldSsz4hG
# SIG # End signature block
