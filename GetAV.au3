#cs ----------------------------------------------------------------------------
 
 Script Name: GetAV
 AutoIt Version: 3.3.8.1
 Author: Scorpio
 
 Script Function:
    Get the installed antivirus in the local machine.

#ce ----------------------------------------------------------------------------

Func GetAV()
	Local $VersionString, $Version, $SecurityCenter, $ObjSecurityCenter, $ColAV, $ObjAV, $GetAV
	
	$VersionString = RegRead("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion", "CurrentVersion")
	$Version = StringSplit($VersionString, ".")

	If $Version[1] >= 6 Then
		$SecurityCenter = "SecurityCenter2"
	Else
		$SecurityCenter = "SecurityCenter"
	EndIf

	Local $ObjSecurityCenter = ObjGet("winmgmts:\\localhost\root\" & $SecurityCenter)
	Local $ColAV = $ObjSecurityCenter.ExecQuery("Select * From AntiVirusProduct")

    For $ObjAV In $ColAV
        $GetAV = $ObjAV.DisplayName
    Next

    If $GetAV = "" Then
	    $GetAV = "Unknown"
	EndIf

	Return $GetAV
EndFunc
