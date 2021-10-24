; ver 1.3.2
	
	;TODO hide_resouces := false
	
	;config
	#MaxThreadsPerHotkey 2
	CoordMode, Mouse, Client
	line_height := 17
	first_line_y := 95 ; 125 ; ;line above the resources
	pinned_embasies_count := 3

	send_hunters_y := first_line_y + line_height
	craft_x := 314
	craft_y := first_line_y + line_height * (5 + pinned_embasies_count)

	astronomical_x := 1257
	astronomical_y := 221

	extra_trades := 0
	debug := 0
	
	;global variables
	stop_main_loop := 1 ;has to get flipped before executing the loop

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
	MouseGetPos, MouseX, MouseY
	PixelGetColor, color, %MouseX%, %MouseY%
	WinGetActiveTitle, Title
	Title := SubStr(Title,1,15)
	MsgBox,%Title% %MouseX% : %MouseY% = %color%. 
	Return

F9:: ;main loop
	;MouseGetPos, start_pos_x, start_pos_y
	
	;hide resources
	MouseClickXY(190, first_line_y, 0)
	Send {Home}
	MouseClickXY(90, first_line_y, 0)
	MouseClickXY(9, first_line_y, 0)
	
	;iterators and semaphores
	j := 0
	run_cleanup := 1
	
	stop_main_loop := !stop_main_loop ;toggle
	while(!stop_main_loop)
	{
		;medium frequency loop actions
		BlockMouseImput(1)
		MouseGetPos, loop_pos_x, loop_pos_y
		
		
		MouseClickXY( 20, send_hunters_y + 3* line_height, stop_main_loop) ;trade 1
		MouseClickXY( 20, send_hunters_y, stop_main_loop) ;hunters
		
		;low frequency loop actions
		if(j>0)
		{
			j--
		}else
		{
			j=5 ;skip loop J times
			
			
		;	MouseClickXY( 20, send_hunters_y + 3* line_height, stop_main_loop) ;trade 1
			
			if(extra_trades)
			{
				MouseClickXY( 20, send_hunters_y + 3* line_height, stop_main_loop) ;trade
			}

			MouseClickXY( 20, send_hunters_y + line_height, stop_main_loop) ;pray
			
			MouseClickXY( craft_x-100, craft_y + line_height *  0, stop_main_loop) ;wood		
			MouseClickXY( craft_x, craft_y + line_height *  1, stop_main_loop) ;beam
			MouseClickXY( craft_x, craft_y + line_height *  2, stop_main_loop) ;slab
			MouseClickXY( craft_x, craft_y + line_height *  4, stop_main_loop) ;steel
			MouseClickXY( craft_x, craft_y + line_height *  3, stop_main_loop) ;plate
		;	MouseClickXY( craft_x, craft_y + line_height *  5, stop_main_loop) ;concrete
		;	MouseClickXY( craft_x, craft_y + line_height *  6, stop_main_loop) ;gear
			MouseClickXY( craft_x, craft_y + line_height *  7, stop_main_loop) ;alloy
			MouseClickXY( craft_x-123, craft_y + line_height *  8, stop_main_loop) ;eludium
		;	MouseClickXY( craft_x, craft_y + line_height *  9, stop_main_loop) ;scaffold
		;	MouseClickXY( craft_x, craft_y + line_height * 10, stop_main_loop) ;ship
		;	MouseClickXY( craft_x, craft_y + line_height * 11, stop_main_loop) ;tanker
			MouseClickXY( craft_x, craft_y + line_height * 12, stop_main_loop) ;kerosene
			MouseClickXY( craft_x, craft_y + line_height * 14, stop_main_loop) ;manuscript
			MouseClickXY( craft_x, craft_y + line_height * 13, stop_main_loop) ;parchment
			MouseClickXY( craft_x, craft_y + line_height * 15, stop_main_loop) ;compedium
			MouseClickXY( craft_x, craft_y + line_height * 16, stop_main_loop) ;blueprint
			MouseClickXY( craft_x, craft_y + line_height * 17, stop_main_loop) ;thorium
		;	MouseClickXY( craft_x, craft_y + line_height * 18, stop_main_loop) ;megalith
		
		;	MouseClickXY( 822, 606, stop_main_loop)
		}
		MouseMove, loop_pos_x, loop_pos_y
		BlockMouseImput(0)
		
		loop, 9 ;wait between resource converting while checking; 1 loop = 0.1 seconds
		{
			;high frequency loop actions
			sleep, 100
			if (stop_main_loop)
				break
			
			;observe the sky
			PixelGetColor, color, astronomical_x, astronomical_y 
			if(color=0xeecd80) ;0x343434) ;0x4C4141)
			{
				BlockMouseImput(1)
				MouseGetPos, loop_pos_x, loop_pos_y
				MouseClickXY(astronomical_x, astronomical_y, stop_main_loop) 
				MouseMove, loop_pos_x, loop_pos_y
				BlockMouseImput(0)
			}
		}
	}
	
	if(run_cleanup)	;loop cleanup
	{
		run_cleanup := 0
		BlockMouseImput(0)
		MouseClickXY(90, first_line_y, 0) ;show resources (if hidden)
		;Mousemove, start_pos_x, start_pos_y
		SplashTextOn,320,,Stopping Auto-clicking for the Kittens Game
		sleep 2000
		SplashTextOff
	}

	Return

XButton2:: ;no more accidental reloading
	Send {Browser_Forward}
	
F7::
MouseClickXY(1246, 138)
sleep 666
MouseClickXY(760, 600)
return

; *****************
; *** functions ***
; *****************

BlockMouseImput(onoff)
{
	if(onoff) ; block mouse input
	{
		BlockInput, MouseMove
		click, up ;prevent selecting page content
		Hotkey, LButton, nothing, On
	;	Hotkey, MButton, nothing, On
	;	Hotkey, RButton, nothing, On
	;	Hotkey, XButton1, nothing, On
	;	Hotkey, XButton2, nothing, On
	;	Hotkey, WheelUp, nothing, On
	;	Hotkey, WheelDown, nothing, On
	}
	else
	{
		BlockInput, MouseMoveOff
		Hotkey, LButton, nothing, Off
	;	Hotkey, MButton, nothing, Off
	;	Hotkey, RButton, nothing, Off
	;	Hotkey, XButton1, nothing, Off
	;	Hotkey, XButton2, nothing, Off
	;	Hotkey, WheelUp, nothing, Off
	;	Hotkey, WheelDown, nothing, Off
	}
	Return
}

nothing:
return

MouseClickXY(x, y, stop_main_loop := 0) ; my cystom click
{
	if (stop_main_loop)
		Return
	
	;Send {Esc}
	
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