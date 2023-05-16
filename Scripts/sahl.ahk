sndTxt := "فيونا"
;!1:: setTxt("فيونا")
;!2:: setTxt("فوتينا")
;!3:: setTxt("فينوس")
;!4:: setTxt("الدكتور")
setTxt(txt){
    global sndTxt
    sndTxt := txt
    MsgBox % sndTxt
}

CoordGetControl(xCoord, yCoord, _hWin) ; _hWin should be the ID of the active window
{
    CtrlArray := Object() 
    WinGet, ControlList, ControlList, ahk_id %_hWin%
    Loop, Parse, ControlList, `n
    {
        Control := A_LoopField
        ControlGetPos, left, top, right, bottom, %Control%, ahk_id %_hWin%
        right += left, bottom += top
        if (xCoord >= left && xCoord <= right && yCoord >= top && yCoord <= bottom)
            MatchList .= Control "|"
    }
    StringTrimRight, MatchList, MatchList, 1
    Loop, Parse, MatchList, |
    {
        ControlGetPos,,, w, h, %A_LoopField%, ahk_id %_hWin%
        Area := w * h
        CtrlArray[Area] := A_LoopField
    }
    for Area, Ctrl in CtrlArray
    {
        Control := Ctrl
        if (A_Index = 1) {
            ;ControlGet, vis, Visible ,, % "ahk_id " Control
            ;MsgBox, % vis " + " Control
            ;if vis = 1
            Break
        }
    }
    return Control
}
SendToPos(Msg, X, Y){
    ActiveHwnd := WinExist("A")
    ClassNN := CoordGetControl(X, Y, ActiveHwnd)
    ControlSend % ClassNN, Msg, A
}

+NumpadMult::
    ActiveHwnd := WinExist("A")
    ClassNN := CoordGetControl(1296,627, ActiveHwnd)
    ControlSend % ClassNN, {Down}{Down}{Down}, A
Return
+NumpadSub::
	MouseGetPos x, y
    t := ControlHWNDAt(1100, 150)
    cn := Control_GetClassNN(ControlHWNDAt(x, y))
    ; ControlGet o, Selected, , %cn%
	ControlGetFocus o, A
	ControlGetText, x, %cn%, A
    msgbox % x
return

Store2ToMain(){
    ActiveHwnd := WinExist("A")
    nn := ControlHWNDAt("1300","627")
    ControlSend ,, {Up}{Up}{Up}, % "ahk_id " nn
    nn := ControlHWNDAt("1200","627")
    ControlSend ,, {Down}{Down}{Down}, % "ahk_id " nn
}
Store3ToMain(){
    ActiveHwnd := WinExist("A")
    nn := ControlHWNDAt("1300","627")
    ControlSend ,, {Up}{Up}{Up}{Down}, % "ahk_id " nn
    nn := ControlHWNDAt("1200","627")
    ControlSend ,, {Down}{Down}{Down}, % "ahk_id " nn
}
MainToStore2(){
    ActiveHwnd := WinExist("A")
    nn := ControlHWNDAt("1300","627")
    ControlSend ,, {Down}{Down}{Down}, % "ahk_id " nn
    nn := ControlHWNDAt("1200","627")
    ControlSend ,, {Up}{Up}{Up}, % "ahk_id " nn
}
MainToStore3(){
    ActiveHwnd := WinExist("A")
    nn := ControlHWNDAt("1300","627")
    ControlSend ,, {Down}{Down}{Down}, % "ahk_id " nn
    nn := ControlHWNDAt("1200","627")
    ControlSend ,, {Up}{Up}{Up}{Down}, % "ahk_id " nn
}
IsActiveWindowTransfere(){
    hwnd := ControlHWNDAt("1200","627")
    name := Control_GetClassNN(hwnd)
    IfInString, name, Lookup
        Return True
Return False
}
Control_GetClassNN(hWndControl){
    DetectHiddenWindows, On
    WinGet, ClassNNList, ControlList, A
    Loop, PARSE, ClassNNList, `n
    {
        ControlGet, hWnd, hwnd,,%A_LoopField%, A
        if (hWnd = hWndControl){
            ; msgbox here %A_LoopField%
        	return A_LoopField
		}
		else{
			; msgbox %hWndControl% .. %hWnd%
		}
    }
	; return xxx
}

ControlHWNDAt(x, y){
    coordmode, mouse, screen
    MouseGetPos ox, oy, , , 2
    MouseMove, x, y, 0
    MouseGetPos x, y, winhandle, controlhandle, 3
    MouseMove, ox, oy, 0
    Return, controlhandle
}
ActiveControls()
{
    WinGet, ActiveControlList, ControlList, A
    ret := ""
    Loop, Parse, ActiveControlList, `n
    {
        ControlName := ControlName(A_LoopField)
        FileAppend,
        (
        Control #%a_index% is "%ControlName%".
        ), D:\Controls.txt 
        ret .= "`nControl [# " a_index ": " A_LoopField "] is '" ControlName "'"
    }
Return ret
}
ControlName(Hwnd){
    ControlFocus, ahk_id %_hwnd%
    ControlGetFocus FocusedCtl, A
Return % FocusedCtl 
}
ControlsAtPos(WinTitle, fx, fy) {
    WinGet, list, ControlListHwnd, A
    ret := ""
    loop, parse, list, `n
    {
        ControlGetPos, x, y, w, h, , ahk_id %A_LoopField%
        
        if (x <= fx && fx <= x+w) && (y <= fy && fy <= y+h){
            name := ControlName(A_LoopField)
            ret .= "`n" name "(" A_LoopField ".."w ")`n"
            ; ControlFocus, ahk_id %A_LoopField%
            SoundBeep, 555, 222
            Sleep, 555
        }
        ; controls can overlap, so a single position could theoretically
        ;   have more than one control
    }
return SubStr(ret, 2)
}

GetMouseOverControl()
{
    Loop
    {
        Sleep, 100
        MouseGetPos, , , WhichWindow, WhichControl
        wc := WhichControl
        ControlGetPos, x, y, w, h, %WhichControl%, ahk_id %WhichWindow%
        ToolTip, %WhichControl%`nX%X%`tY%Y%`nW%W%`t%H% `n %wc%
    }
}
GetFocusedControlClassNN( )
{
    GuiWindowHwnd := WinExist("A")		;stores the current Active Window Hwnd id number in "GuiWindowHwnd" variable
    ;"A" for Active Window
    ControlGetFocus, FocusedControl, ahk_id %GuiWindowHwnd%	;stores the  classname "ClassNN" of the current focused control from the window above in "FocusedControl" variable
    ;"ahk_id" searches windows by Hwnd Id number
    MsgBox, %ForcusedControl%
return, FocusedControl
}
GetFocusedControlHwnd( )
{
    GuiWindowHwnd := WinExist("A")		;stores the current Active Window Hwnd id number in "GuiWindowHwnd" variable
    ;"A" for Active Window
    ControlGetFocus, FocusedControl, ahk_id %GuiWindowHwnd%	;stores the  classname "ClassNN" of the current focused control from the window above in "FocusedControl" variable
    ;"ahk_id" searches windows by Hwnd Id number
    ControlGet, FocusedControlId, Hwnd,, %FocusedControl%, ahk_id %GuiWindowHwnd%	;stores the Hwnd Id number of the focused control found above in "FocusedControlId" variable
return, FocusedControlId
}