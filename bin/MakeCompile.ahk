; Copy the Setup script into bin
FileCopy, ..\Setup.ahk, Setup.ahk, 1
if (ErrorLevel)
{
	MsgBox Error. Could not copy file.
	Return
}
	
; Read the script
FileRead, FileContents, Setup.ahk

if (ErrorLevel)
{
	MsgBox Error. Could not read file.
	Return
}

; Replace the Extension (ahk => exe)
StringReplace, FileContents, FileContents, global Extension := "ahk", global Extension := "exe"

; Compensate for the executable moving down a directory
StringReplace, FileContents, FileContents, assets\300i.jpg, ..\assets\300i.jpg

; Overwrite the Setup script
FileDelete, Setup.ahk
FileAppend, %FileContents%, Setup.ahk

; Compile the script into an executable using Ahk2Exe (included when you install AutoHotkey
Run, "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "%A_WorkingDir%\Setup.ahk" /out "%A_WorkingDir%\Setup.exe"
; Wait for the operation to complete (shouldn't take more than a few milliseconds)
Sleep, 1000
; Delete the extra Setup.ahk file
FileDelete, Setup.ahk