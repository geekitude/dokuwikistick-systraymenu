#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=DokuWikiStickGeekitude.ico
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <Constants.au3>
#include <File.au3>
#include <WindowsConstants.au3>

Opt("TrayAutoPause", 0)
Opt("TrayMenuMode", 3)

; ============================
; == Read DokuWikiStick.ini ==
; ============================
; == Global ==
$Force = IniRead("DokuWikiStick.ini", "Browser", "Force", 0)
If ($Force = 1) Then
	$Browser = IniRead("DokuWikiStick.ini", "Browser", "Browser", "")
Else
	$Browser = ""
EndIf

TraySetToolTip ("DokuWikiStick")
Global $delay, $nobrowser
If ($CmdLine[0] = 0) Then
	$delay = 2000
	$nobrowser = 0
Else
	For $param = 1 to ($CmdLine[0])
		Select
		Case StringLeft (StringLower($CmdLine[$param]), 7) = "/sleep:"
			Local $sleep = StringSplit($CmdLine[$param], ":")
			If ((Number($sleep[2]) > 0) And (Number($sleep[2]) <= 10) And (Number($sleep[2]) = Int(Number($sleep[2])))) Then
				$delay = Int(Number($sleep[2])) * 1000
			Else
				$delay = "error"
			EndIf
		Case (StringLower($CmdLine[$param]) = "/nb")
			$nobrowser = 1
		Case Else
			Help()
		EndSelect
	Next
EndIf

If FileExists(@ScriptDir & "\server\mapache.exe") Then
	If ($delay ="error") Then
		TrayTip("DokuWikiStick", "Starting MicroApache (wrong sleep time given)...", 2, 2)
		$delay = 2000
	ElseIf ($delay > 0) Then
		TrayTip("DokuWikiStick", "Starting MicroApache (sleeping " & $delay / 1000 &" secs)...", 2, 2)
	Else
		TrayTip("DokuWikiStick", "Starting MicroApache...", 2, 2)
	EndIf
  	FileChangeDir (@ScriptDir & "\server")
	Run("mapache.exe", "", @SW_MINIMIZE)
	If ($nobrowser = 0) Then
		Sleep($delay)
		;MsgBox(0, "DokuWikiStick", $Browser)
		If (FileExists($Browser)) Then
			Run($Browser & " " & "http://localhost:8800/doku.php")
		Else
			ShellExecute("http://localhost:8800/doku.php")
		EndIf
	EndIf
	Menu()
Else
	MsgBox(16, "Error", "Missing \server\mapache.exe")
	Exit
EndIf

Func Menu()
	Local $idBrowseDWS = TrayCreateItem("Browse DokuWikiStick website")
	Local $idRestart = TrayCreateItem("Restart MicroApache")
	Local $idExploreDWS = TrayCreateItem("Explore DokuWikiStick folder")
	If FileExists(@MyDocumentsDir & "\GitHub") Then
		TrayCreateItem("")
		Local $idBrowseGH = TrayCreateItem("Browse GitHub website")
		Local $idExploreGH = TrayCreateItem("Explore Documents\GitHub folder")
	Else
		Local $idBrowseGH = Null
		Local $idExploreGH = Null
	EndIf
	TrayCreateItem("")
	Local $idExit = TrayCreateItem("Exit")
	While 1
		Switch TrayGetMsg()
			Case $idBrowseDWS
				ShellExecute("http://localhost:8800/doku.php")
			Case $idRestart
				TrayTip("DokuWikiStick", "Restarting MicroApache...", 2, 2)
				Run("ApacheKill.exe")
				Sleep(1000)
				Run("mapache.exe", "", @SW_MINIMIZE)
			Case $idExploreDWS
				ShellExecute(@ScriptDir)
			Case $idBrowseGH
				ShellExecute("https://github.com")
			Case $idExploreGH
				ShellExecute(@MyDocumentsDir & "\GitHub")
			Case $idExit
				KillApache()
		EndSwitch
	WEnd
EndFunc

Func KillApache()
	TrayTip("DokuWikiStick", "Killing MicroApache...", 2, 2)
	Run("ApacheKill.exe")
	Sleep(1000)
	Exit
EndFunc

Func Help()
	Local $help =  "DokuWikiStick.exe [options] " & @CRLF _
		& @CRLF _
		& "[options]:" & @CRLF _
		& "/sleep:n = pause n seconds (0 to 10) between MicroApache start and Browse" & @CRLF _
		& "/nb = no browser launched" & @CRLF _
		& @CRLF _
		& "By default, there will be a 2 seconds pause." & @CRLF _
		& @CRLF
	MsgBox(64, "Aide", $help)
	Exit
EndFunc