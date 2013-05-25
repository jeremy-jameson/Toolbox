<#
.SYNOPSIS
Removes one or more folders from the Path environment variable.

.PARAMETER Folders
Specifies the folders to remove from the Path environment variable..

.PARAMETER EnvironmentVariableTarget
Specifies the "scope" to use for the Path environment variable ("Process",
"Machine", or "User"). Defaults to "Process" if the parameter is not specified.

.EXAMPLE
.\Remove-PathFolders.ps1 C:\NotBackedUp\Public\Toolbox
#>
param(
    [parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string[]] $Folders,
    [string] $EnvironmentVariableTarget = "Process")

begin
{
    Set-StrictMode -Version Latest
    $ErrorActionPreference = "Stop"

    Write-Verbose "Path environment variable target: $EnvironmentVariableTarget"

    [bool] $isInputFromPipeline =
        ($PSBoundParameters.ContainsKey("Folders") -eq $false)

    [int] $foldersRemoved = 0

    [string[]] $pathFolders = [Environment]::GetEnvironmentVariable(
        "Path",
        $EnvironmentVariableTarget) -Split ";"

    [Collections.ArrayList] $folderList = New-Object Collections.ArrayList

    $pathFolders | foreach {
        $folderList.Add($_) | Out-Null
    }
}

process
{
    If ($isInputFromPipeline -eq $true)
    {
        $items = $_
    }
    Else
    {
        $items = $Folders
    }

    $items | foreach {
        [string] $folder = $_

        [bool] $isFolderInList = $false

        for ([int] $i = 0; $i -lt $folderList.Count; $i++)
        {
            If ([string]::Compare($folderList[$i], $folder, $true) -eq 0)
            {
                $isFolderInList = $true

                Write-Verbose ("Removing folder ($folder) from Path" `
                    + " environment variable...")

                $folderList.RemoveAt($i)
                $i--

                $foldersRemoved++
            }
        }

        If ($isFolderInList -eq $false)
        {
            Write-Verbose ("The folder ($folder) is not specified in the Path" `
                + " list.")

        }
    }
}

end
{
    If ($foldersRemoved -eq 0)
    {
        Write-Verbose ("No changes to the Path environment variable are" `
            + " necessary.")

        return
    }

    [string] $delimitedFolders = $folderList -Join ";"

    [Environment]::SetEnvironmentVariable(
        "Path",
        $delimitedFolders,
        $EnvironmentVariableTarget)

    Write-Verbose ("Successfully removed $foldersRemoved folder(s) from Path" `
        + " environment variable.")
}
