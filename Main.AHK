#Requires AutoHotkey v2.0
SoundBeep 250, 60

#SingleInstance Force
SetWorkingDir A_ScriptDir

^!s::{
    Send "^s"
    Sleep 500
    Reload
}
; #Include ./Scripts/Switchlang.ahk
; #Include %A_ScriptDir%
; #Include KeyboardLayout.ahk
; #Include BrightnessSetter.ahk
; SetTimer SecondsTimer, 999
;settimer,alert,250
; BS := new BrightnessSetter()
; CoordMode Mouse, Screen

#End::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

numToNumpad(a){
    splt := StrSplit(a)
    keys := ""
    for i, e in splt
        keys := keys "{Numpad" e "}"

    return keys
}

!+w::{
    ;generate and send {alt + numkeys} !1 to up to !255
    loop 255{
        n := numToNumpad(A_Index)
        SendInput A_Index ":" "{LAlt DOWN}" n "{LAlt UP}"
        SendInput "{Enter}"
    }
}

; !E:: Run A_ComSpec " /c Taskkill -f -im electron.exe," A_ScriptDir,"Hide"
; #+l:: Run "D:\- Code\- python\watch-to-linkedin\watch-linkedin.exe"
;</em>{left 5}
; Hotstring options:
; C/C1 : Case sensitive/insensitive
; d0/d1 : auto-delete the hotstring after sending
; s0/s1 : auto-space after sending
; * : don't wait for a space|tab|enter after the hotstring
; ? : execute even if is part of other word
:C*d0:`:ss` d::MsgBox("sb hot-string is sent",,"T1")

F4::SendMessage 0x112, 0xF170, 2, , "Program Manager" ; Monitor off

!x:: {
    if WinActive("ahk_exe taskmgr.exe")
        ProcessClose "taskmgr.exe"
    Else
        Send "!{F4}"
}

!c:: Run("Calc")
^!x::{
    RunWait A_ComSpec " /c Taskkill -f -im explorer.exe"
    Run("explorer")
}

alert(){
    coordmode "mouse", "screen"
    MouseGetPos &x, &y, &winhandle, &controlhandle, 2
    ; setformat integer, hex
    handle_ := DllCall("WindowFromPoint", "Int", x, "Int", y)
    handle_ += 0
    tooltip "mouse=" winhandle controlhandle ", foundhandle=" handle_
}

!q::{ ;control get screen coordinates
    FilePath := "D:\CODE\PYTHON\test.xlsx" ; example path
    SoundBeep 850, 200
    oWorkbook := ComObjGet(FilePath) ; access Workbook object
    SoundBeep 850, 200
    MsgBox oWorkbook.Sheets(1).Range("B1").Value ; get value from A1 cell in first sheet
}

consoleHidden := false
RunWaitOne(command) {
    global consoleHidden
    if (not consoleHidden){
        DllCall("AllocConsole")
        h := DllCall("GetConsoleWindow", "ptr")
        consoleHidden := true
        WinHide("ahk_id " h)
    }

    shell := ComObject("WScript.Shell")
    ; Execute a single command via cmd.exe
    exec := shell.Exec(A_ComSpec " /C " command)
    ; Read and return the command's output
    ; while, !objExec.StdOut.AtEndOfStream
    return exec.StdOut.ReadAll()
}

#+f::{
    SetTitleMatchMode 3
    if(WinExist("fman – NOT REGISTERED") AND not WinExist("fman"))
        Return WinActivate("fman – NOT REGISTERED")

    ToolTip ""
    tesser := '"C:\Program Files\Tesseract-OCR\tesseract.exe"'
    fman := '"C:\Users\mrt\AppData\Local\fman\fman.exe"'
    image := "C:\Users\mrt\Desktop\fman.jpg"
    tesserCmd := A_ComSpec " /C " tesser " " image " stdout -l eng"

    if (not winExist("fman"))
        Run(fman)

    WinWait("fman")
    Sleep 500
    WinActivate("fman")
    winGetClientPos(&x, &y, , , "fman")
    nirCmd := 'nircmd savescreenshot "' image '" ' x + 235 ' ' y + 100 ' 90 25'
    RunWaitOne(nirCmd)
    SoundBeep 250, 60
    result:=RunWaitOne(tesserCmd)
    SoundBeep 250, 60

    x := 75
    y := 150
    if(InStr(result, "B."))
        x += 100
    if(InStr(result, "C."))
        x += 200
    WinActivate("fman")
    Click(x, y)
}

^!+E::Run('"code" "' . A_ScriptDir '"')
^!+Z::run "C:\Program Files\Google\Chrome\Application\chrome.exe --profile-directory=`"Default`""
Launch_Mail::{
    SoundBeep 250, 60
    if ProcessExist("SoundBooster.exe") = 0
        Return Run("C:\Program Files (x86)\Letasoft Sound Booster\SoundBooster.exe")

    ProcessClose("SoundBooster.exe")
    SoundBeep 250, 60
    SoundBeep 250, 60
}
!b::Send "^!{Break}"

#+g:: runGitBash()
runGitBash(){
    cmd := " `"cd " getActiveExplorerDir() " && start %ProgramFiles%\Git\bin\sh.exe --login`""
    cmd := "C:\Program Files\Git\usr\bin\sh.exe --login"
    run cmd, getActiveExplorerDir()
}

~LButton & z::msgbox("test"), msgbox("test2")

~LButton & WheelUp::Util.getSelectedText(False), SoundBeep(250, 60)

~LButton & MButton::Send("^v"), SoundBeep(250, 60)

getActiveExplorerDir(){
    _hwnd := WinExist("A")
    wClass := WinGetClass("A")
    if (wClass == "ExploreWClass" || wClass == "CabinetWClass")
        for window in ComObject("Shell.Application").Windows
            if (window.hwnd == _hwnd)
                _path := window.Document.Folder.Self.Path
    return _path ?? A_Desktop
}

#Include "Scripts/gui.ahk"
; #Include "Scripts/hotstrings.ahk"
#Include "Scripts/input-hooks/input-hooks.ahk"
#Include "Scripts/modifiers-mon.ahk"
#Include "Scripts/keyboard.ahk"
#Include "Scripts/google-translate/google-translate.ahk"
; #Include "Scripts/auto-complete.ahk"
#Include "Scripts/Quranflash.ahk"
#Include "Scripts/RunCMD.ahk"
