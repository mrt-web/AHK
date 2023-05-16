; #SingleInstance Force
; SendMode "Input"
; SetWorkingDir A_ScriptDir

; getActiveExplorerDir(){
;     _hwnd := WinExist("A")
;     WinGetClass wClass, ahk_id %_hwnd%
;     if (wClass == "ExploreWClass" || wClass == "CabinetWClass")
;         for window in ComObjCreate("Shell.Application").Windows
;             if (window.hwnd == _hwnd)
;                 _path := window.Document.Folder.Self.Path
;     return % _path ? _path : A_Desktop
; }

; msgbox "test"


^!c::runCMD()
^!+c::runCMDAdmin()

runCMDAdmin(){
    CommandRoot(, "admin")
}
runCMD(){
    CommandRoot( )
    ; CommandRoot(, "admin", "winTerminal")
}
CommandRoot(subroutine := "", parameters*) {
    ; Get path of active window.
    _hwnd := WinExist("A")
    WinGetClass &wClass, "ahk_id " _hwnd
    if (wClass == "ExploreWClass" || wClass == "CabinetWClass")
        for window in ComObject("Shell.Application").Windows
            if (window.hwnd == _hwnd)
                _path := window.Document.Folder.Self.Path

    ; Parse parameters.
    admin := bind := color := exit := hide := max := min := pause := run := stderr := stdout := wait := 0
    for i,param in parameters {
        admin := (param = "admin") ? 1 : admin
        bind := (param = "bind") ? 1 : bind
        color := (param ~= "color") ? i : color
        exit := (param = "exit") ? 1 : exit
        hide := (param = "hide") ? 1 : hide
        max := (param = "max") ? 1 : max
        min := (param = "min") ? 1 : min
        pause := (param = "pause") ? 1 : pause
        root := (param = "root") ? 1 : root
        run := (param = "run") ? 1 : run
        stderr := (param = "stderr") ? 1 : stderr
        stdout := (param = "stdout") ? 1 : stdout
        wait := (param = "wait") ? 1 : wait

        winTerminal := (param = "winTerminal") ? 1 : 0
    }

    _return := (stderr || stdout) ? 1 : 0
    _path := (root) ? A_ScriptDir : (_path) ? _path : A_Desktop
    _win := (hide) ? "hide" : (max) ? "max" : (min) ? "min" : ""

    static q := Chr(0x22)
    ; Escape double quote character.

    ; Construct the command to execute.
    if (run) {
        _cmd := (admin) ? "*RunAs " subroutine : subroutine
    } else {
        wt := "C:\Users\mrt\AppData\Local\Microsoft\WindowsApps\wt.exe"
        _cmd .= (winTerminal) ? ((admin) ? "*RunAs " wt : wt) : ((admin) ? "*RunAs " A_ComSpec : A_ComSpec)
        _cmd .= (color) ? " /T:" SubStr(parameters[color], -1) " " : ""
        _cmd .= (winTerminal) ? "" : ((exit && !_return) ? " /C " : " /K ") ; disable to run windowsterminal
        _cmd .= (admin) ? " /d " q _path q " " : ""
        _cmd .= (admin && subroutine != "" && !_return) ? " && " : ""
        _cmd .= (subroutine != "" && !_return) ? subroutine : ""
        _cmd .= (pause && !_return) ? " && pause" : ""
    }

    ; Disable SysWow64 redirection when running as 32-bit autohotkey on 64-bit OS. RunAs will FAIL if run as 32-bit on 64-bit OS.
    if (!admin && A_Is64bitOS && A_PtrSize == 4)
        DllCall("Wow64DisableWow64FsRedirection", "Ptr*", "oldRedirectionValue")

    ; Get name of current process.
    VarSetStrCapacity(&_process, 2048)
    DllCall("GetModuleFileName", "int", 0, "str", _process)
    SplitPath _process,,,, _process
    ; Execute. Errors will fail silently due to "try".
    _pid := ""
    try {
        if (wait)
            RunWait _cmd, _path, _win, _pid
        else
            Run _cmd, _path, _win, _pid
    }
    finally {
        if (bind || (_return && exit)) {
            ; The following command launches a cmd.exe process that checks to see if the parent process (this script) has exited or not.
            ; If the parent process (ex. AutoHotkey.exe) that calls the child process (ex. cmd.exe) exits, then forcefully quit
            ; the child process. If the child process exits, then this process will exit.
            ; This is necessary because passing "stderr" or "stdout" will prevent the CommandRoot() process from exiting itself.
            ; Memory usage: Slowly climbs and stabilizes to 8196 KB from my testing.
            ;_exit := Comspec " /q /c for /L %n in (1,0,10) do (timeout /t 1 1>NUL && (tasklist /FI " q "PID eq "
            ;      . DllCall("GetCurrentProcessId") q " 2>NUL | find /I /N " q _process q " 1>NUL || TASKKILL /PID "
            ;      . _pid " /F 2>NUL) & (tasklist /FI " q "PID eq " _pid q " 2>NUL | find /I /N " q _pid q " 1>NUL || exit))"
            _exit := "powershell -NoProfile -command " q "& {Do {if (Get-Process -id " DllCall("GetCurrentProcessId")
                . " | where {$_.Processname -eq '" _process "'}) {sleep 1} else {Get-Process -id " _pid
                . " | foreach {$_.CloseMainWindow(); Stop-Process -id $_.id}}} while (Get-Process -id " _pid ")}" q
            Run _exit,, "Hide"
        }
    }
    Try
    return 0

    VarSetStrCapacity(&_process, 0)

    ; Restore SysWow64.
    ; if (oldRedirectionValue)
    t := DllCall("Wow64RevertWow64FsRedirection", "Ptr", "oldRedirectionValue") ; consider exiting if, for whatever unlikely reason, this returns False

    ; If "stdout" or "stderr" is passed, attach to the console and run subroutine.
    if (_return && !run) {
        _dhw := "A_DetectHiddenWindows"
        DetectHiddenWindows True
        WinWait "ahk_pid " _pid
        DllCall("AttachConsole", "uint", _pid)
        objShell := ComObject("WScript.Shell")
        objExec := objShell.Exec(A_ComSpec " /c " q subroutine q)
        while (!objExec.Status)
            Sleep 10
        _stdout := objExec.StdOut.ReadAll()
        _stderr := objExec.StdErr.ReadAll()
        DllCall("FreeConsole")
        PostMessage 0x112, 0xF060,,, "ahk_pid " _pid ; 0x112 = WM_SYSCOMMAND, 0xF060 = SC_CLOSE
        DetectHiddenWindows _dhw
    }

    return (stdout && stderr) ? {0:_pid, 1:_stdout, 2:stderr} : (stdout) ? _stdout : (stderr) ? _stderr : _pid
}

SecondsTimer()	{

    If WinExist "New version of Internet Download Manager is available"
    {
        WinClose ; same
        WinClose ; same
        SoundBeep 200, 200
        WinActivate ; Automatically uses the window found above.
        WinWaitActive ; same
        WinClose "A"
        Send "{Escape}"
        Send "{Escape}"
        Send "{Escape}"
        Send "{Escape}"
    }
}
