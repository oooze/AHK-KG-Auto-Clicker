; ver 1.2.2
	
	;TODO hide_resouces := false
	
	;config
	#MaxThreadsPerHotkey 2
	line_height := 17
	first_line_y := 95
	pinned_embasies_count := 3

	send_hunters_y := first_line_y + line_height
	craft_x := 377
	craft_y := first_line_y + line_height * (4 + pinned_embasies_count)

	astronomical_x := 1257
	astronomical_y := 221

	extra_trades := 0
	debug := 0
	
	;global variables
	main_loop_off_toggle := 0

F10:: ;reload the script
	SplashTextOn,,, Reloading the script...
	sleep 500
	Reload
	Sleep 1000
	SplashTextOn,,, Failed to reload.
	Sleep 3000
	SplashTextOff
	Return

F12:: ;insect pixel
	CoordMode, Mouse, Client
	MouseGetPos, MouseX, MouseY
	PixelGetColor, color, %MouseX%, %MouseY%
	WinGetActiveTitle, Title
	Title := SubStr(Title,1,15)
	MsgBox,%Title% %MouseX% : %MouseY% = %color%. 
	Return

^7::
F7:: ;main loop
	CoordMode, Mouse, Client
	MouseGetPos, start_pos_x, start_pos_y
	
	;hide resources
	MouseClickXY(90, first_line_y, 0)
	MouseClickXY(9, first_line_y, 0)
	
	;iterators
	i=0
	j=0
	
	main_loop_off_toggle := !main_loop_off_toggle
	while(main_loop_off_toggle)
	{
		;break
		;observe the sky
		PixelGetColor, color, astronomical_x, astronomical_y 
		if(color=0xeecd80) ;0x343434) ;0x4C4141)
		{
			MouseGetPos, loop_pos_x, loop_pos_y
			BlockInput, Mouse
			MouseClickXY(astronomical_x, astronomical_y, main_loop_off_toggle) 
			Mousemove, loop_pos_x, loop_pos_y
			BlockInput, Off
		}

		if(i<1)
		{
			i=10 ;number of loop skips between  1 loop = 0.1 seconds
			BlockInput, Mouse
			MouseGetPos, loop_pos_x, loop_pos_y
			;Click, left, loop_pos_x, loop_pos_y, 1, 0, U
			Click, Up ;prevent selecting content
			Click, Up Right
			
			MouseClickXY( 150, send_hunters_y + 3* line_height, main_loop_off_toggle) ;trade 1
			MouseClickXY( 100, send_hunters_y, main_loop_off_toggle) ;hunters
			
			break
			
			if(j<1)
			{
				j=11
				
				
			if(extra_trades = 1)
			{
				MouseClickXY( 150, send_hunters_y + 3* line_height, main_loop_off_toggle) ;trade
			}

				MouseClickXY( 150, send_hunters_y + line_height, main_loop_off_toggle) ;pray
				
				MouseClickXY( 240, craft_y + line_height *  0, main_loop_off_toggle) ;wood		
				MouseClickXY( craft_x, craft_y + line_height *  1, main_loop_off_toggle) ;beam
			;	MouseClickXY( craft_x, craft_y + line_height *  2, main_loop_off_toggle) ;slab
			;	MouseClickXY( craft_x, craft_y + line_height *  4, main_loop_off_toggle) ;steel
			;	MouseClickXY( craft_x, craft_y + line_height *  3, main_loop_off_toggle) ;plate
			;	MouseClickXY( craft_x, craft_y + line_height *  5, main_loop_off_toggle) ;concrete
			;	MouseClickXY( craft_x, craft_y + line_height *  6, main_loop_off_toggle) ;gear
			;	MouseClickXY( craft_x, craft_y + line_height *  7, main_loop_off_toggle) ;alloy
			;	MouseClickXY( craft_x, craft_y + line_height *  8, main_loop_off_toggle) ;eludium
			;	MouseClickXY( craft_x, craft_y + line_height *  9, main_loop_off_toggle) ;scaffold
			;	MouseClickXY( craft_x, craft_y + line_height * 10, main_loop_off_toggle) ;ship
			;	MouseClickXY( craft_x, craft_y + line_height * 11, main_loop_off_toggle) ;tanker
			;	MouseClickXY( craft_x, craft_y + line_height * 12, main_loop_off_toggle) ;kerosene
			;	MouseClickXY( craft_x, craft_y + line_height * 14, main_loop_off_toggle) ;manuscript
			;	MouseClickXY( craft_x, craft_y + line_height * 13, main_loop_off_toggle) ;parchment
			;	MouseClickXY( craft_x, craft_y + line_height * 15, main_loop_off_toggle) ;compedium
			;	MouseClickXY( craft_x, craft_y + line_height * 16, main_loop_off_toggle) ;blueprint
			;	MouseClickXY( craft_x, craft_y + line_height * 17, main_loop_off_toggle) ;thorium
			;	MouseClickXY( craft_x, craft_y + line_height * 18, main_loop_off_toggle) ;megalith
			
			;	MouseClickXY( 822, 606, main_loop_off_toggle) 
			}
			j--
			Mousemove, loop_pos_x, loop_pos_y
			BlockInput, Off
		}
		i--

		if (main_loop_off_toggle = 1)
			break
		sleep, 100

	}
	Mousemove, start_pos_x, start_pos_y
	
	SplashTextOn,320,,Stopping Auto-clicking for the Kittens Game
	sleep 2000
	SplashTextOff
	Return

XButton2::
	Send {Browser_Forward}
F8::
	main_loop_off_toggle = 1
	Return

^F9:: ;testing toggle
	If first_run=true
	{
		first_run=false
	}
	else
	{
		first_run=true
	}
	MsgBox, %first_run%
	Return



; *****************
; *** functions ***
; *****************

MouseClickXY(x, y, main_loop_off_toggle := 1) ; my cystom click
{
	if (main_loop_off_toggle != 0)
		Return
	
	Send {Esc}
	
	if(debug) ; if debug
	{
		Click, Up %x% %y%
		SplashTextOn,,, clicking at %x% / %y%.
		Sleep 300
		SplashTextOff
	}
	else {
		Click, %x% %y%
	}

}	
	Return


BWait (amount, interval, exit) ;better wait, that can be interrupted
{
	if(interval<1)
		Return

	while (amount > interval)
	{
		amount -= interval
		sleep, interval
		if (exit = 1)
			Return
	}
	sleep, amount
	Return
}