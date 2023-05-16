
Run "C:\Program Files\Roblox"

LeftClick:
	Click 
return


leftClicked = false ;

Numpad0::
	if leftClicked = true
	{
		SetTimer LeftClick, Off
		leftClicked = false
	}else
	{
		interval := 11/timesPerSecond
		SetTimer LeftClick, % interval
		leftClicked = true
	}
return
f1:: Reload
Esc::
	SoundBeep 550, 250
	process, close, ApplicationFrameHost.exe
	ExitApp
return