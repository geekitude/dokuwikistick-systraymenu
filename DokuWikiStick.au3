#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=DokuWikiStickGeekitude.ico
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <Constants.au3>
#include <WindowsConstants.au3>

Opt("TrayAutoPause", 0)
Opt("TrayMenuMode", 3)

TraySetToolTip ("DokuWikiStick")

If FileExists(@ScriptDir & "\server\mapache.exe") Then
	TrayTip("DokuWikiStick", "Starting MicroApache...", 2, 2)
  	FileChangeDir (@ScriptDir & "\server")
	Run("mapache.exe", "", @SW_MINIMIZE)
	ShellExecute("http://localhost:8800/doku.php")
	Sleep(2000)
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
				Run("mapache.exe")
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