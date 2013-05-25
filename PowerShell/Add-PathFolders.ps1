<#
.SYNOPSIS
Adds one or more folders to the Path environment variable.

.PARAMETER Folders
Specifies the folders to add to the Path environment variable..

.PARAMETER EnvironmentVariableTarget
Specifies the "scope" to use for the Path environment variable ("Process",
"Machine", or "User"). Defaults to "Process" if the parameter is not specified.

.EXAMPLE
.\Add-PathFolders.ps1 C:\NotBackedUp\Public\Toolbox
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

    [int] $foldersAdded = 0

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

        $folderList | foreach {
            If ([string]::Compare($_, $folder, $true) -eq 0)
            {
                Write-Verbose ("The folder ($folder) is already included" `
                    + " in the Path environment variable.")

                $isFolderInList = $true
                return
            }
        }

        If ($isFolderInList -eq $false)
        {
            Write-Verbose ("Adding folder ($folder) to Path environment" `
                + " variable...")

            $folderList.Add($folder) | Out-Null

            $foldersAdded++
        }
    }
}

end
{
    If ($foldersAdded -eq 0)
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

    Write-Verbose ("Successfully added $foldersAdded folder(s) to Path" `
        + " environment variable.")
}
