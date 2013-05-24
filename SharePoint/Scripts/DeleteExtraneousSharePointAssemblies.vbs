Option Explicit

Dim strFolder
strFolder = "."

If (WScript.Arguments.Count = 1) Then
    strFolder = WScript.Arguments(0)
ElseIf (WScript.Arguments.Count > 1) Then
    WScript.Echo("Usage: DeleteExtraneousSharePointAssemblies.vbs [folder]")
    WScript.Quit(1)
End If

Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")

Dim folder
Set folder = fso.GetFolder(strFolder)

If (InStr(folder, "Program Files") > 0) Then
    WScript.Echo("Error: Cannot delete assemblies from Program Files")
    WScript.Quit(1)
End If

Wscript.Echo "Scanning: " & folder.Path

DeleteExtraneousSharePointAssemblies folder

Sub DeleteExtraneousSharePointAssemblies(folder)
    Wscript.Echo "Scanning: " & folder.Path

    Dim file
    For Each file in folder.Files
        If file.Name = "Microsoft.Office.Server.Search.dll" _
            Or file.Name = "Microsoft.Office.Workflow.Feature.dll" _
            Or file.Name = "Microsoft.SharePoint.Portal.SingleSignon.dll" _
            Or file.Name = "Microsoft.SharePoint.Search.dll" _
            Or file.Name = "Microsoft.SharePoint.Search.xml" Then

            If (Not (file.Attributes And 1 = file.Attributes)) Then
                Wscript.Echo "Removing read-only flag from file: " & file.Path
                file.Attributes = file.Attributes XOr 1
            End If

            Wscript.Echo "Deleting " & file.Path
            file.Delete(false)
        End If
    Next

    Dim subFolder
    For Each subFolder in Folder.SubFolders
        DeleteExtraneousSharePointAssemblies subFolder
    Next
End Sub
