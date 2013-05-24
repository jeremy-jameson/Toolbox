Option Explicit

If (WScript.Arguments.Count <> 1) Then
    WScript.Echo("Usage: cscript DeleteEmptyFolders.vbs {path}")    
    WScript.Quit(1)
End If

Dim strPath
strPath = WScript.Arguments(0)

Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")

Dim objFolder
Set objFolder = fso.GetFolder(strPath)

DeleteEmptyFolders objFolder

Sub DeleteEmptyFolders(folder)
    Dim subfolder
    For Each subfolder in folder.SubFolders
        DeleteEmptyFolders subfolder
    Next
    
    If folder.SubFolders.Count = 0 And folder.Files.Count = 0 Then
        WScript.Echo folder.Path & " is empty"
        fso.DeleteFolder folder.Path
    End If    
End Sub
