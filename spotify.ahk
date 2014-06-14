; Works even if Spotify is running in the background
DetectHiddenWindows, On

; The first parameter passed to the script
ARG = %1%

if ( ARG == "next" )
{
	; The key name is sent as a string
	SendInputToSpotify("^{Right}")
}
else if ( ARG == "vdown" )
{
	SendInputToSpotify("^{Down 3}")
}
else if ( ARG == "vup" )
{
	SendInputToSpotify("^{Up 3}")
}
else if ( ARG == "pauseplay" )
{
	SendInputToSpotify("{Space}")
}

; This function sends the keystroke to Spotify
SendInputToSpotify(key)
{
	; ControlSend [, Control, Keys, WinTitle, WinText, ExcludeTitle, ExcludeText]
	
	; here, the key name is interpolated
	ControlSend, ahk_parent, (%key%), ahk_class SpotifyMainWindow
}

DetectHiddenWindows, Off 