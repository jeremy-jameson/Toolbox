If WScript.Arguments.Count > 1 Then
    WScript.Echo
    WScript.Echo "Usage: cscript ""Clear Event Logs.vbs"" [computer name]"
    WScript.Echo
    WScript.Quit
End If

Dim strComputer ' As String

If WScript.Arguments.Count > 0 Then
    strComputer= WScript.Arguments(0)
Else
    strComputer= "localhost"
End If

ClearEventLogs strComputer

WScript.Echo "Done"

Private Sub ClearEventLogs( _
    strComputer)

    WScript.Echo "Clearing event logs on " & strComputer & "..."

    Set objWMIService = GetObject( _
        "winmgmts:" & "{impersonationLevel=impersonate,(Backup)}!\\" _
            & strComputer & "\root\cimv2")

    Set colLogFiles = objWMIService.ExecQuery( _
        "Select * from Win32_NTEventLogFile")

    For Each objLogfile in colLogFiles
        ClearEventLog strComputer, objLogfile.LogfileName
    Next
End Sub

Private Sub ClearEventLog( _
    strComputer, _
    strEventLogName)

    WScript.Echo "Clearing '" & strEventLogName & "' event log on " _
        & strComputer & "..."

    Set objWMIService = GetObject( _
        "winmgmts:" & "{impersonationLevel=impersonate,(Backup)}!\\" _
            & strComputer & "\root\cimv2")

    Set colLogFiles = objWMIService.ExecQuery( _
        "Select * from Win32_NTEventLogFile where LogFileName='" _
            & strEventLogName & "'")

    For Each objLogfile in colLogFiles
    Dim backupFilename
    backupFilename= "C:\" & strEventLogName & "_" & GetFormattedTimestamp() _
        & ".evt"

        errBackupLog = objLogFile.BackupEventLog(backupFilename)
        If errBackupLog <> 0 Then        
            WScript.Echo "The " & strEventLogName & " event log on " _
                & strComputer & " could not be backed up."
        Else
            objLogFile.ClearEventLog()
        End If
    Next
End Sub

Private Function GetFormattedTimestamp()
    Dim timestamp
    timestamp = Now

    GetFormattedTimestamp = Year(timestamp) _
        & LPad(Month(timestamp), 2, "0") _
        & LPad(Day(timestamp), 2, "0") _
        & "_" & Replace(FormatDateTime(timestamp, 4), ":", "")
	
End Function

Private Function LPad( _
    strValue, _
    nLength, _
    strPadCharacter)

    Dim strPaddedValue

    strPaddedValue = strValue

    While (Len(strPaddedValue) < nLength)
        strPaddedValue = strPadCharacter & strPaddedValue
    WEnd

    LPad = strPaddedValue
End Function