keyhistory 20
InstallKeybdHook
persistent
F8:: keyhistory

#+q:: hk(1) ; disable all keys

hk(f:=0) { ; By FeiYue
    static allkeys, Excluded_Keys:="LButton,RButton,1,2,3,4,5,6,7,8,9,0,Numpad0,Numpad1,Numpad2,Numpad3,Numpad4,Numpad5,Numpad6,Numpad7,Numpad8,Numpad9,backspace"
    if !allkeys
    {
        s:="||NumpadEnter|Home|End|PgUp|PgDn|Left|Right|Up|Down|Del|Ins|"
        Loop 254
            k:=GetKeyName(Format("VK{:02X}",A_Index))
                , s.=InStr(s, "|" k "|") ? "" : k "|"
        For k,v in {Control:"Ctrl",Escape:"Esc"}
            s:=StrReplace(s, k, v)
        allkeys:=Trim(s, "|")
    }
    ;------------------
    f:=f ? "On":"Off"
    For k,v in StrSplit(allkeys,"|")
        if not InStr(Excluded_Keys, v)
            Hotkey v, 'Block_Input', f 'UseErrorLevel'
    Block_Input:
    Return

}

; leftClicked = false;
; timesPerSecond = 100 ; رات في الثانية 		Alt+F3
; ; auto click
; ^!Numpad0::
;     if leftClicked = true
;     {
;         SetTimer LeftClick, Off
;         leftClicked = false
;     }else{
;         interval := 11/timesPerSecond
;         SetTimer LeftClick, % interval
;         leftClicked = true
;     }
; return