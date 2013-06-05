<#
.SYNOPSIS
Removes one or more host names from the BackConnectionHostNames registry value.

.DESCRIPTION
The BackConnectionHostNames registry value is used to bypass the loopback
security check for specific host names.

.LINK
http://support.microsoft.com/kb/896861

.EXAMPLE
.\Remove-BackConnectionHostNames.ps1 fabrikam-local, www-local.fabrikam.com
#>
param(
    [parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string[]] $HostNames)

begin
{
    Set-StrictMode -Version Latest
    $ErrorActionPreference = "Stop"

    function GetBackConnectionHostNameList
    {
        [Collections.ArrayList] $hostNameList = New-Object Collections.ArrayList

        [string] $registryPath =
            "HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0"

        $registryKey = Get-Item -Path $registryPath

        $registryValue = $registryKey.GetValue("BackConnectionHostNames")

        $registryValue |
            ForEach-Object {
                $hostNameList.Add($_) | Out-Null
            }

        # HACK: Return an array (containing the ArrayList) to avoid issue with
        # PowerShell returning a string (when registry value only contains one
        # item)
        return ,$hostNameList
    }

    function SetBackConnectionHostNamesRegistryValue(
        [Collections.ArrayList] $hostNameList =
            $(Throw "Value cannot be null: hostNameList"))
    {
        $hostNameList.Sort()

        for ([int] $i = 0; $i -lt $hostNameList.Count; $i++)
        {
            If ([string]::IsNullOrEmpty($hostNameList[$i]) -eq $true)
            {
                $hostNameList.RemoveAt($i)
                $i--
            }
        }

        [string] $registryPath =
            "HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0"

        $registryKey = Get-Item -Path $registryPath

        $registryValue = $registryKey.GetValue("BackConnectionHostNames")

        If ($hostNameList.Count -eq 0)
        {
            Remove-ItemProperty -Path $registryPath `
                -Name BackConnectionHostNames
        }
        ElseIf ($registryValue -eq $null)
        {
            New-ItemProperty -Path $registryPath -Name BackConnectionHostNames `
                -PropertyType MultiString -Value $hostNameList | Out-Null
        }
        Else
        {
            Set-ItemProperty -Path $registryPath -Name BackConnectionHostNames `
                -Value $hostNameList | Out-Null
        }
    }

    [bool] $isInputFromPipeline =
        ($PSBoundParameters.ContainsKey("HostNames") -eq $false)

    [int] $hostNamesRemoved = 0

    [Collections.ArrayList] $hostNameList = GetBackConnectionHostNameList
}

process
{
    If ($isInputFromPipeline -eq $true)
    {
        $items = $_
    }
    Else
    {
        $items = $HostNames
    }

    $items | foreach {
        [string] $hostName = $_

        [bool] $isHostNameInList = $false

        for ([int] $i = 0; $i -lt $hostNameList.Count; $i++)
        {
            If ([string]::Compare($hostNameList[$i], $hostName, $true) -eq 0)
            {
                Write-Verbose ("Removing host name ($hostName) from" `
                    + " BackConnectionHostNames list...")

                $hostNameList.RemoveAt($i)
                $i--

                $hostNamesRemoved++

                $isHostNameInList = $true
            }
        }

        If ($isHostNameInList -eq $false)
        {
            Write-Verbose ("The host name ($hostName) is not" `
                + " specified in the BackConnectionHostNames list.")

        }
    }
}

end
{
    If ($hostNamesRemoved -eq 0)
    {
        Write-Verbose ("No changes to the BackConnectionHostNames registry" `
            + " value are necessary.")

        return
    }

    SetBackConnectionHostNamesRegistryValue $hostNameList

    Write-Verbose ("Successfully removed $hostNamesRemoved host name(s)" `
        + " from the BackConnectionHostNames registry value.")
}
