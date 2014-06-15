; MARK - READ FILE

; FileReadLine, OutputVar, Filename, LineNum
FileReadLine, flight_mode, FlightModeState, 1

; If file doesn't exist
if (ErrorLevel)
	; Default to 7 (111)
	flight_mode := 7

	
	
; MARK - GET FLIGHT MODE

; first param
ARG = %1%

if ( ARG == "reset" )
	; flight_mode: 111
	flight_mode := 7

else if ( ARG == "couple" )
{
	; if the current flight mode doesn't match the intended one,
	if ( flight_mode | 4 != flight_mode )
		; toggle coupling
		Send {Blind}{CapsLock}

	; flight_mode: 1xx
	flight_mode := (flight_mode | 4) ; flight_mode <bitwise-or> 4
	; example:
	;		flight_mode == 3 (011)
	;		"couple" => 3 (011) <bitwise-or> 4 (100) => 7 (111)
	; call function that will send the keystroke to Star Citizen
}
else if ( ARG == "decouple" )
{
	if ( flight_mode & 3 != flight_mode )
		Send {Blind}{CapsLock}

	; flight_mode: 0xx
	flight_mode := (flight_mode & 3) ; flight_mode <bitwise-and> 3
	; example:
	;		flight_mode == 7 (111)
	;		"couple" => 7 (011) <bitwise-and> 3 (011; mask for 100) => 3 (011)
}
else if ( ARG == "g-on" )
{
	if ( flight_mode | 2 != flight_mode )
		CycleFlightModes(3)
	
	; flight_mode: x1xO
	flight_mode := (flight_mode | 2)
}
else if ( ARG == "g-off" )
{
	if ( flight_mode & 5 != flight_mode )
		CycleFlightModes(1)
	
	; flight_mode: x0x
	flight_mode := (flight_mode & 5)
}
else if ( ARG == "c-on" )
{
	if ( flight_mode | 1 != flight_mode )
		CycleFlightModes(2)

	; flight_mode: xx1
	flight_mode := (flight_mode | 1)
}
else if ( ARG == "c-off" )
{
	if ( flight_mode & 6 != flight_mode )
		CycleFlightModes(2)

	; flight_mode: xx0
	flight_mode := (flight_mode & 6)
}



; MARK - WRITE TO FILE

; Delete the file so that a new one can take its place
FileDelete, FlightModeState
; Append the contents of flight_mode to the file
FileAppend, %flight_mode%, FlightModeState

CycleFlightModes(number_of_times)
{
	Loop %number_of_times%
	{
		Send {Blind}^{CapsLock}
		Sleep, 40	
	}
}



;DEBUG_START
; If you uncomment the below line, this script will insert the number matching the current flight
; model state wherever your cursor is. This can be used along with modes.txt (in the same directory)
; to verify correctness.
;SendInput %flight_mode%
;DEBUG_END