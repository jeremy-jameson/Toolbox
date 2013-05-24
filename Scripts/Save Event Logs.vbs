If WScript.Arguments.Count > 1 Then
    WScript.Echo
    WScript.Echo "Usage: cscript ""Save Event Logs.vbs"" [computer name]"
    WScript.Echo
    WScript.Quit
End If

Dim strComputer ' As String

If WScript.Arguments.Count > 0 Then
    strComputer= WScript.Arguments(0)
Else
    strComputer= "localhost"
End If

SaveEventLogs strComputer

WScript.Echo "Done"

Private Sub SaveEventLogs(strComputer)
    WScript.Echo "Saving event logs on " & strComputer & "..."

    SaveEventLog strComputer, "Application"
    'SaveEventLog strComputer, "Security"
    SaveEventLog strComputer, "System"
End Sub

Private Sub SaveEventLog(strComputer, strEventLogName)
    Set objWMIService = GetObject("winmgmts:" _
        & "{impersonationLevel=impersonate,(Backup)}!\\" & _
            strComputer & "\root\cimv2")

    Set colLogFiles = objWMIService.ExecQuery _
        ("Select * from Win32_NTEventLogFile where LogFileName='" _
            & strEventLogName & "'")

    For Each objLogfile in colLogFiles
        Dim backupFilename
        backupFilename = "\"

        If (Not strComputer = "localhost") Then
            backupFilename = backupFilename & strComputer & "_"
        End If

        backupFilename = backupFilename & strEventLogName & "_" _
            & GetFormattedTimestamp() & ".evt"

        errBackupLog = objLogFile.BackupEventLog(backupFilename)
        If errBackupLog <> 0 Then        
            WScript.Echo "The " & strEventLogName & " event log on " _
                & strComputer & " could not be backed up."
        End If
    Next
End Sub

Private Function GetFormattedTimestamp
    Dim timestamp
    timestamp = Now

    GetFormattedTimestamp = Year(timestamp) _
        & LPad(Month(timestamp), 2, "0") _
        & LPad(Day(timestamp), 2, "0") _
        & "_" & Replace(FormatDateTime(timestamp, 4),":","")
	
End Function

Private Function LPad(strValue, nLength, strPadCharacter)
    Dim strPaddedValue

    strPaddedValue = strValue

    While (Len(strPaddedValue) < nLength)
        strPaddedValue = strPadCharacter & strPaddedValue
    WEnd

    LPad = strPaddedValue
End Function