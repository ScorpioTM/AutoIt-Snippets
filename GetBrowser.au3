#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author: Scorpio

 Script Function:
	Get the system default browser.

#ce ----------------------------------------------------------------------------

MsgBox(16, "Test", GetBrowser())

Func GetBrowser()
  Local $Value = RegRead("HKEY_CLASSES_ROOT\HTTP\shell\open\command\", "")
  $Value = StringLeft($Value, StringInStr($Value, ".exe") + 4)
	Return $Value
EndFunc
