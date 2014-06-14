#SingleInstance

SetupMainGUI()

Return




SetupMainGUI()
{
	global
	
	Gui, Margin, 15, 15
	
	Gui, Add, Picture, w500 h-1 x0 y0, assets\300i.jpg
	
	Gui, Add, Text, x10, Navigate to the folder with the profiles subfolder and AutoHotkey scripts:
	Gui, Add, Button, gBrowseScripts yp-5 x370, Browse
	Gui, Add, Text, cGreen x50 vProjectDirectory w480
	
	Gui, Add, Text, x10, Select an output folder in which to put all your scripts and profile:
	Gui, Add, Button, gBrowseOutput yp-5 x370, Browse
	Gui, Add, Text, cGreen x50 vOutputDirectory w480
	
	Gui, Add, Text,, Include the following command groups:
	Gui, Add, Checkbox, vFlightModes, Flight Modes
	Gui, Add, Checkbox, yp xp+100 vSpotify, Spotify
	Gui, Add, Checkbox, yp xp+70 vOtherCommands, Other commands (power, targeting, etc.)
	
	Gui, Add, Button, gConvert, Convert Files and Finish
	
	Gui, Show, w500, Convert VoiceAttack Profile
}

RetrieveProfile(FilePath)
{
	FileRead, FileContents, %FilePath%
	Return FileContents
}

PrepareOutputDirectory()
{
	FileRemoveDir, %OutputDirectory%, 1
	FileCreateDir, %OutputDirectory%
}

UpdatePathsInProfile()
{
	Replace := "<Context>.*(\\.*\.ahk)</Context>"
	Replacement := "<Context>" . OutputDirectory . "$1</Context>"
	ProfileContents := RegExReplace(ProfileContents, Replace, Replacement)
}

SaveFilesToOutputDirectory(ByRef ProfileName, ByRef ProfileContents, FlightModes, Spotify)
{
	FileDelete, %OutputDirectory%\%ProfileName%-Profile.vap
	FileAppend, %ProfileContents%, %OutputDirectory%\%ProfileName%-Profile.vap
	if ( FlightModes)
	{
		FileCopy, %ProjectDirectory%\flightmode.ahk, %OutputDirectory%\flightmode.ahk, 1
	}
	if ( Spotify )
	{
		FileCopy, %ProjectDirectory%\spotify.ahk, %OutputDirectory%\spotify.ahk, 1
	}
}

BrowseScripts:
	FileSelectFolder, Path,,, Navigate to the folder with the AutoHotkey scripts
	Gui, Submit, NoHide
	if (!ErrorLevel)
	{
		GuiControl,, ProjectDirectory, %Path%
		ProjectDirectory = %Path%
		global ProjectDirectory := ProjectDirectory
	}
Return

BrowseOutput:
	FileSelectFolder, Path, 1,, Select an output folder in which to put all your scripts and profile
	Gui, Submit, NoHide
	if (!ErrorLevel)
	{
		GuiControl,, OutputDirectory, %Path%
		OutputDirectory = %Path%
		OutputDirectory := OutputDirectory . "\SC-VoiceAttack-AutoHotkey"
		global OutputDirectory := OutputDirectory
	}
Return

Convert:
	Gui, Submit, NoHide

	if ( !ProjectDirectory )
	{
		MsgBox Error! Please choose a script input directory.
		Return
	}
	
	if ( !OutputDirectory )
	{
		MsgBox Error! Please choose an output directory.
		Return
	}
	
	if ( !FlightModes && !Spotify && !OtherCommands )
	{
		MsgBox Error! Please choose at least one command category.
		Return
	}
	
	ProfileName := ""
	
	if ( FlightModes )
	{
		ProfileName := "Flight"
	}
	
	if ( Spotify )
	{
		ProfileName := ProfileName . "Spotify"
	}
	
	if ( OtherCommands )
	{
		ProfileName := ProfileName . "Other"
	}
	
	ProfilePath := ProjectDirectory . "\profiles\" . ProfileName . "-Profile.vap"
	ProfileContents := RetrieveProfile(ProfilePath)
	
	PrepareOutputDirectory()
	
	UpdatePathsInProfile()
	
	SaveFilesToOutputDirectory(ProfileName, ProfileContents, FlightModes, Spotify)
	
	FileDelete, newprofile.txt
	FileAppend, %ProfileContents%, newprofile.txt
	
Return

GuiClose:
	ExitApp
Return