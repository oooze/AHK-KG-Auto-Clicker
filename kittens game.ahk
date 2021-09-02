; ver 1.2.2

	;config
	resource_first_row_y := 95
	rows_from_top_number := 0 ; 29
	line_height := 17

	send_hunters_y := resource_first_row_y + rows_from_top_number * line_height
	craft_offset_x := 377
	craft_offset_y := send_hunters_y + line_height * 5

	astronomical_x := 1257
	astronomical_y := 221

	extra_trades := 0

F10::
	
	SplashTextOn,,, Reloading the script...
	sleep 500
	Reload
	Sleep 1000
	SplashTextOn,,, Failed to reload.
	Sleep 3000
	SplashTextOff
	Return

F12::	;insect pixel
	CoordMode, Mouse, Client
	MouseGetPos, MouseX, MouseY
	PixelGetColor, color, %MouseX%, %MouseY%
	WinGetActiveTitle, Title
	Title := SubStr(Title,1,15)
	MsgBox,%Title% %MouseX% : %MouseY% = %color%. 
	Return

^7::
F7::


	CoordMode, Mouse, Client
	MouseGetPos, start_pos_x, start_pos_y
	
	; *** hide resources ***
	click, 90 100
	click, 9 100
	
	i=0
	j=0
	break_loop=0

	loop
	{
	;	break
		if (break_loop = 1)
		{
			break
		}
		
		; observe the sky
		PixelGetColor, color, astronomical_x, astronomical_y 
		if(color=0xeecd80) ;0x343434) ;0x4C4141)
		{
			MouseGetPos, loop_pos_x, loop_pos_y
			BlockInput, Mouse
			MouseClickXY(astronomical_x, astronomical_y, break_loop) 
			Mousemove, loop_pos_x, loop_pos_y
			BlockInput, Off
		}

		if(i<1)
		{
			i=10 ; how many loops skip clicking the workshop: 1 loop = 0.1 seconds
			MouseGetPos, loop_pos_x, loop_pos_y
			BlockInput, Mouse
			;Click, left, loop_pos_x, loop_pos_y, 1, 0, U
			click, up left ;prevent selecting content
			
			if(extra_trades = 1)
			{
				craft_offset_y := send_hunters_y + line_height * 6
				MouseClickXY( 150, send_hunters_y + 4* line_height, break_loop) ;trade
			}
			else
			{
				MouseClickXY( 150, send_hunters_y + 3* line_height, break_loop) ;trade
			}
			MouseClickXY( 100, send_hunters_y, break_loop) ;hunters
			
			break
			
			if(j<1)
			{
				j=11
				
				
			if(extra_trades = 1)
			{
				MouseClickXY( 150, send_hunters_y + 3* line_height, break_loop) ;trade
			}

				MouseClickXY( 150, send_hunters_y + line_height, break_loop) ;pray
				
				MouseClickXY( 240, craft_offset_y + line_height *  0, break_loop) ;wood		
				MouseClickXY( craft_offset_x, craft_offset_y + line_height *  1, break_loop) ;beam
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height *  2, break_loop) ;slab
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height *  4, break_loop) ;steel
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height *  3, break_loop) ;plate
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height *  5, break_loop) ;concrete
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height *  6, break_loop) ;gear
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height *  7, break_loop) ;alloy
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height *  8, break_loop) ;eludium
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height *  9, break_loop) ;scaffold
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height * 10, break_loop) ;ship
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height * 11, break_loop) ;tanker
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height * 12, break_loop) ;kerosene
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height * 14, break_loop) ;manuscript
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height * 13, break_loop) ;parchment
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height * 15, break_loop) ;compedium
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height * 16, break_loop) ;blueprint
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height * 17, break_loop) ;thorium
			;	MouseClickXY( craft_offset_x, craft_offset_y + line_height * 18, break_loop) ;megalith
			
			;	MouseClickXY( 822, 606, break_loop) 
			}
			j--
			Mousemove, loop_pos_x, loop_pos_y
			BlockInput, Off
		}
		i--

		if (break_loop = 1)
			break
		sleep, 100
		
		;break
	}
	Mousemove, start_pos_x, start_pos_y
	
	SplashTextOn,320,,Stopping Auto-clicking for the Kittens Game
	sleep 2000
	SplashTextOff
	Return

XButton2::
	Send {Browser_Forward}
F8::
	break_loop = 1
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

MouseClickXY(x, y, break_loop := 1) ; my cystom click
{
	if (break_loop != 0)
		Return
	
	Send {Esc}
	
	if(1) ; if debug
	{
		Click, Up %x% %y%
		SplashTextOn,,, clicking at %x% / %y%.
		Sleep 3000
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