; set the working directory
setworkingdir,%A_scriptdir%
; prevent additional instances from being created
#SingleInstance On
; MAIN SCRIPT

; set Extension type
Extension := "ahk"
	
; Create a GUI
; top & left margin: 15 pixels
Gui, Margin, 15, 15

; image banner for the top of the window
; h-1 forces the picture to keep its aspect ratio when it is resized
Gui, Add, Picture, w500 h-1 x0 y0, assets\300i.jpg

; prompt text, a button, and an initially empty text label below
Gui, Add, Text, x10, Navigate to the folder with the profiles subfolder and AutoHotkey scripts:
; yp-n positions the element relative to its parent element by n pixels
Gui, Add, Button, gBrowseInput yp-5 x370, Browse
; when the below text label has content, it will be green
Gui, Add, Text, cGreen x50 vProjectDirectory w480

Gui, Add, Text, x10, Select an output folder in which to put all your scripts and profile:
Gui, Add, Button, gBrowseOutput yp-5 x370, Browse
Gui, Add, Text, cGreen x50 vOutputDirectory w480

; add 3 checkboxes with associated variables (which would return either a 0 or 1, depending on the checkbox's state
Gui, Add, Text,, Include the following command groups:
Gui, Add, Checkbox, vFlightModes, Flight Modes
Gui, Add, Checkbox, yp xp+100 vSpotify, Spotify
Gui, Add, Checkbox, yp xp+70 vOtherCommands, Other commands (power, targeting, etc.)

; submit button
Gui, Add, Button, gConvert, Convert Files and Finish

; show the GUI window
Gui, Show, w500, Setup VoiceAttack Profile

; finish executing commands at this point
Return

; function that gets the chosen profile from the source directory
RetrieveProfile(FilePath)
{
	; read the file at the corresponding file path, and store its contents in FileContents
	FileRead, FileContents, %FilePath%
	Return FileContents
}

; FUNCTIONS

; function that creates a fresh directory at target output directory
PrepareOutputDirectory(ByRef OutputDirectory)
{
	; remove the directory, 1 = recursively
	FileRemoveDir, %OutputDirectory%, 1
	; create the new directory
	FileCreateDir, %OutputDirectory%
	if (ErrorLevel)
	{
		MsgBox directory error
	}
}

; function that finds any reference to AutoHotkey scripts and updates their location to reflect
; the new directory
UpdatePathsInProfile(ByRef ProfileContents, ByRef Extension, ByRef OutputDirectory)
{
	; the regular expression with which to replace the correct text
	; EXPLANATION:
	; <Context> ----------------- the opening Context tag that would surround the 
	;                             filepath attribute for the specific VoiceAttack command
	;     .* -------------------- any extra characters that might have made it there somehow (unlikely)
	;         (\\ --------------- since the filename must be captured, this defines the leftmost border of said filename
	;             .* ------------ matches whatever may be in the filename, including spaces
	;                 \.[type] ----- the dot must be escaped, because otherwise it just means 'any character'
	;         ) -----------------
	; </Context> ---------------- the closing tag, of course, needs to go, too.
	Replace := "<Context>.*(\\.*\.)ahk</Context>"
	; the string that will replace whatever match is found
	Replacement := "<Context>" . OutputDirectory . "$1" . Extension . "</Context>"
	; perform the actual match and save the resulting replaced string into ProfileContents
	ProfileContents := RegExReplace(ProfileContents, Replace, Replacement)
}

; function that saves the profile and requested AutoHotkey scripts to the target output directory
SaveFilesToOutputDirectory(ByRef OutputDirectory, ByRef ProjectDirectory, ByRef ProfileName, ByRef ProfileContents, FlightModes, Spotify, ByRef Extension)
{
	; this can be further refactored in a later release to be more general
	; create the new profile in the output directory
	FileAppend, %ProfileContents%, %OutputDirectory%\%ProfileName%-Profile.vap
	; if the FlightModes boolean is true, copy it to the directory as well
	if ( FlightModes)
	{
		FileRead, check, %ProjectDirectory%\scripts\flightmode.%Extension%
		if ( ErrorLevel )
		{
			MsgBox Error! Could not find flightmode.%Extension%.
			Return
		}
		else
		{
			FileCopy, %ProjectDirectory%\scripts\flightmode.%Extension%, %OutputDirectory%\flightmode.%Extension%
		}
		
	}
	; same for Spotify
	if ( Spotify )
	{
		FileRead, check, %ProjectDirectory%\scripts\spotify.%Extension%
		if ( ErrorLevel )
		{
			MsgBox Error! Could not find spotify.%Extension%.
			Return
		}
		else
		{
			FileCopy, %ProjectDirectory%\scripts\spotify.%Extension%, %OutputDirectory%\spotify.%Extension%
		}
	}
	MsgBox, 4, Success!, Done! You can find your files at %OutputDirectory%. Would you like to open that directory now?
	IfMsgBox Yes
		Run, %OutputDirectory%
}

; CONTROL SUBROUTINES

; this subroutine is fired when the first browse button is clicked
BrowseInput:
	; opens a Browse dialog box to get a folder from the user ( 1 means a directory is mandatory )
	FileSelectFolder, Path, 1,, Navigate to the folder with the AutoHotkey scripts
	; submits control variables (NoHide prevents this from minimizing the GUI)
	Gui, Submit, NoHide
	if (!ErrorLevel)
	{
		; Sets the ProjectDirectory label in the GUI
		GuiControl,, ProjectDirectory, %Path%
		; Gets a reference to the ProjectDirectory
		ProjectDirectory = %Path%
	}
Return

; this subroutine is fired when the second browse button is clicked
BrowseOutput:
	FileSelectFolder, Path, 1,, Select an output folder in which to put all your scripts and profile
	Gui, Submit, NoHide
	if (!ErrorLevel)
	{
		GuiControl,, OutputDirectory, %Path%
		OutputDirectory = %Path%
		; appends an additional subdirectory onto the output directory
		OutputDirectory := OutputDirectory . "\SC-VoiceAttack-AutoHotkey"
	}
Return

; this subroutine is fired when the Convert button is pressed
Convert:
	Gui, Submit, NoHide

	; makes sure there is a project directory selected
	if ( !ProjectDirectory )
	{
		MsgBox Error! Please choose an input directory.
		Return
	}
	
	; makes sure there is an output directory selected
	if ( !OutputDirectory )
	{
		MsgBox Error! Please choose an output directory.
		Return
	}
	
	; makes sure at least one package is selected
	if ( !FlightModes && !Spotify && !OtherCommands )
	{
		MsgBox Error! Please choose at least one command package.
		Return
	}
	
	; resets the profile name
	ProfileName := ""
	
	; appends "Flight" if the FlightModes checkbox is checked
	if ( FlightModes )
	{
		ProfileName := "Flight"
	}
	
	; same as above. Note that this string is appended to the end of the last, if it exists.
	if ( Spotify )
	{
		ProfileName := ProfileName . "Spotify"
	}
	
	; same. Voila! This gives you 7 possible choices for a profile.
	if ( OtherCommands )
	{
		ProfileName := ProfileName . "Other"
	}
	
	; creates a profile path to be retrieved from the project (input) directory
	ProfilePath := ProjectDirectory . "\profiles\" . ProfileName . "-Profile.vap"
	; retrieves the contents from that path (SEE: above)
	ProfileContents := RetrieveProfile(ProfilePath)
	
	; sets up the output directory (SEE: above)
	PrepareOutputDirectory(OutputDirectory)
	
	; updates the profile to match the output directory (SEE: above)
	UpdatePathsInProfile(ProfileContents, Extension, OutputDirectory)
	
	; passes a profile name, the profile's contents, and booleans that indicate whether certain packages are requested
	; NEEDS SERIOUS REFACTORING
	SaveFilesToOutputDirectory(OutputDirectory, ProjectDirectory, ProfileName, ProfileContents, FlightModes, Spotify, Extension)
Return

; this subroutine fires when the Close button is clicked, or the window is closed in any other traditional fashion.
GuiClose:
	; exits the app
	ExitApp
Return
