#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author: Scorpio

 Script Function:
	Get the current Operative System.

 References:
	https://msdn.microsoft.com/en-us/library/mt723418(v=vs.85).aspx
	https://msdn.microsoft.com/en-us/library/ms724833(v=vs.85).aspx

#ce ----------------------------------------------------------------------------

ConsoleWrite(GetOS(True) & @CRLF)

Func GetOS($ServicePack = False)
	Local $Pointer, $Return

	$Pointer = DllStructCreate('DWORD;DWORD;DWORD;DWORD;DWORD;WCHAR[128];WORD;WORD;WORD;BYTE;BYTE')
	DllStructSetData($Pointer, 1, DllStructGetSize($Pointer))

	DllCall("ntdll.dll", "int", "RtlGetVersion", "ptr", DllStructGetPtr($Pointer))
	If @Error Then Return SetError(1, 0, "Error calling RtlGetVersion")

	Switch DllStructGetData($Pointer, 2)
		Case 10
			If DllStructGetData($Pointer, 10) = 0x0000001 Then
				$Return = "Windows 10"
			Else
				$Return = "Windows Server 2016"
			EndIf
		Case 6
			Switch DllStructGetData($Pointer, 3)
				Case 3
					If DllStructGetData($Pointer, 10) = 0x0000001 Then
						$Return = "Windows 8.1"
					Else
						$Return = "Windows Server 2012 R2"
					EndIf
				Case 2
					If DllStructGetData($Pointer, 10) = 0x0000001 Then
						$Return = "Windows 8"
					Else
						$Return = "Windows Server 2012"
					EndIf
				Case 1
					If DllStructGetData($Pointer, 10) = 0x0000001 Then
						$Return = "Windows 7"
					Else
						$Return = "Windows Server 2008 R2"
					EndIf
				Case 0
					If DllStructGetData($Pointer, 10) <> 0x0000001 Then
						$Return = "Windows Server 2008"
					Else
						$Return = "Windows Vista"
					EndIf
			EndSwitch
		Case 5
			Switch DllStructGetData($Pointer, 3)
				Case 2
					Local $GetSystemMetrics = DllCall("User32.dll", "int", "GetSystemMetrics", "int", 89)
					If @Error Then SetError(2, 0, "Error calling GetSystemMetrics")
					If $GetSystemMetrics[0] <> 0 Then
						$Return = "Windows Server 2003 R2"
					ElseIf DllStructGetData($Pointer, 9) = 0x00008000 Then
						$Return = "Windows Home Server"
					ElseIf $GetSystemMetrics[0] = 0 Then
						$Return = "Windows Server 2003"
					ElseIf DllStructGetData($Pointer, 10) = 0x0000001 And @OSArch <> "X86" Then
						$Return = "Windows XP Professional x64 Edition"
					EndIf
				Case 1
					$Return = "Windows XP"
				Case 0
					$Return = "Windows 2000"
			EndSwitch
	EndSwitch

	If StringLen($Return) > 0 Then
		If $ServicePack Then
			Return $Return & " " & DllStructGetData($Pointer, 6)
		Else
			Return $Return
		EndIf
	Else
		Return SetError(3, 0, "Unkwnown System")
	EndIf
EndFunc
