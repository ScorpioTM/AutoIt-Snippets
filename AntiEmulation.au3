#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author: Scorpio

 Script Function:
  Detect if the application is being emulated.

#ce ----------------------------------------------------------------------------

AntiEmulation(1000)

Func AntiEmulation($Delay)
    Local $FirstTick = DllCall("kernel32.dll", "dword", "GetTickCount")
    Sleep($Delay)
    Local $SecondTick = DllCall("kernel32.dll", "dword", "GetTickCount")
    
    If $SecondTick[0] - $FirstTick[0] = $Delay Then
        Return False
    Else
        Return True
    EndIf
EndFunc
