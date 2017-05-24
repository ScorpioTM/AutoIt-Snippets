#cs ----------------------------------------------------------------------------

 Script Name: GetInfo UDF
 AutoIt Version: 3.3.8.1
 Author: Scorpio & Blau
 Date: 27/07/2014

 Script Function:
	Get the basic information of the system using the Windows Registry.

#ce ----------------------------------------------------------------------------

MsgBox(64, "Test GetInfo", "Username: " & GetInfo("username") & @CRLF & _
  "Computername: " & GetInfo("computername") & @CRLF & _
	"CPU: " & GetInfo("cpu") & @CRLF & _
	"GPU: " & GetInfo("gpu") & @CRLF & _
	"Architecture: " & GetInfo("architecture") & @CRLF & _
	"Motherboard: " & GetInfo("motherboard") & @CRLF & _
	"Manufacturer: " & GetInfo("manufacturer") & @CRLF & _
	"Default Browser: " & GetInfo("browser"))

Func GetInfo($Info)
	Select
		Case $Info = "Username"
      Return RegRead("HKEY_CURRENT_USER\Volatile Environment", "USERNAME")

		Case $Info = "Computername"
      Return RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName", "ComputerName")

		Case $Info = "CPU"
      Return RegRead("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0", "ProcessorNameString")

		Case $Info = "GPU"
			If @OSArch = "X64" Then
        Return RegRead("HKEY_LOCAL_MACHINE64\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winsat", "PrimaryAdapterString")
			Else
				Return RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winsat", "PrimaryAdapterString")
			EndIf

		Case $Info = "Architecture"
      Return RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment", "PROCESSOR_ARCHITECTURE")

		Case $Info = "Motherboard"
			Return RegRead("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\BIOS", "BaseBoardProduct")

		Case $Info = "Manufacturer"
      Return RegRead("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\BIOS", "BaseBoardManufacturer")

		Case $Info = "Browser"
      $Value = RegRead("HKEY_CLASSES_ROOT\HTTP\shell\open\command\", "")
      Return StringLeft($sValue, StringInStr($sValue, ".exe") + 4)

		Case Else
			Return "Error - No match was found."
	EndSelect
EndFunc
