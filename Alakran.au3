#cs ----------------------------------------------------------------------------
 
 Script Name: Alakran
 AutoIt Version: 3.3.8.1
 Author: Scorpio
 
 Script Function:
    My own basic text encryption and decryption algorithm.
 
#ce ----------------------------------------------------------------------------

Func AlakranCipher($sString, $sKey)
    Local $Seed,  $Final, $i

    For $i = 1 To StringLen($sKey)
        $Seed = ($Seed + Asc(StringLeft($sKey, 1))) * StringLen($Skey)
        $sKey = StringMid($sKey, 2)
    Next

    For $i = 1 To StringLen($sString)
        $Final &= Asc(StringLeft($sString, 1)) + $Seed
        $sString = StringMid($sString, 2)
    Next

    Return $Final
EndFunc

Func AlakranUncipher($sString, $sKey)
    Local $Seed, $Final, $Step, $i

    For $i = 1 To StringLen($sKey)
        $Seed = ($Seed + Asc(StringLeft($sKey, 1))) * StringLen($Skey)
        $sKey = StringMid($sKey, 2)
    Next

    $Step = StringLen($Seed) + Asc(StringLeft($sKey, 1))

    For $i = $Step To StringLen($sString) Step $Step
        $Final &= Chr(StringLeft($sString, $Step) - $Seed)
        $sString = StringMid($sString, $Step + 1)
    Next

    Return $Final
EndFunc
