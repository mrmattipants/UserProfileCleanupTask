Dim WshShell, strCurDir
Set WshShell = CreateObject("WScript.Shell")
strCurDir    = WshShell.CurrentDirectory
CreateObject("Wscript.Shell").Run """" & strCurDir & "\Setup-UserProfileCleanupTask.bat" & """" ,0,True
Set WshShell = Nothing