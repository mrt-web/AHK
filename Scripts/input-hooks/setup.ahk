InputHooks := []

RegisterInputHook(hookName){
    global InputHooks
    InputHooks.Push(HookPattern(hookName))
}

join(Array, Delim := "_", startIndex := 1){
    joined := ""
    for i, e in Array
        if (i >= startIndex)
            joined .= e . Delim
    Return RTrim(joined, Delim)
}

class HookPattern{
    __New(hookMatch){ ; set tr lang *
        this.hookMatch := join(StrSplit(hookMatch, A_Space), A_Space) ; set tr lang*
        this.hasArgs := InStr(this.hookMatch, "*") > 0

        this.hookStr := StrReplace(this.hookMatch, "*", "") ; set tr lang
        this.hookItems := StrSplit(this.hookStr, A_Space) ; [set, tr, lang]

        this.hookCallback := StrReplace(this.hookStr, " ", "_") ; set_tr_lang
    }
    _execute(cmd){
        cmdItems := StrSplit(cmd, A_Space)
        cmdMatch := join(cmdItems)

        if (InStr(cmdMatch, this.hookCallback) != 1)
            Return False
        if(StrLen(cmdMatch) = StrLen(this.hookCallback) and not this.hasArgs){
            %"ih_" . this.hookCallback%()
            Return True
        }
        if (this.hasArgs){
            cmdArgs := StrReplace(cmd, this.hookStr, "",,,1)
            cmdArgs := Trim(cmdArgs)
            ; msgbox "should be here"
            %"ih_" . this.hookCallback%(cmdArgs)
            Return True
        }
        Return False
    }
    execute(cmd){
        ; try 
        Return this._execute(cmd)
        ; catch as e
        ;     if(inStr(e.Message, "not found")>0)
        ;         MsgBox "Command callback not found 'wrong named!'"
        ;             . "`n`nOriginal Error msg:`n" . e.Message,,3

        ; Return False
    }

}



^+;::{
    global InputHooks
    ToolTip ":"

    hookMatches := ""
    for _, e in InputHooks
        hookMatches .= e.hookMatch . ","

    hook := InputHook("", "{Esc}", RTrim(hookMatches, ","))

    hook.onEnd := onEnd
    hook.onChar := onChar
    hook.OnKeyDown := onKeyDown
    ; hook.BackspaceIsUndo := True
    hook.KeyOpt("{Backspace}", "+NS")
    hook.KeyOpt("{Enter}", "+NIS")
    hook.Start()

    Accept := False

    onChar(ih, char)
    {
        ToolTip ":" . ih.input
    }

    onEnd(ih)
    {
        if (ih.EndReason = "EndKey")
            Return ToolTip("")

        onChar(ih, "")
        SoundBeep 550, 250

        called := False
        for i, e in InputHooks{
            called := e.execute(ih.input)
            if (called)
                Break
        }

        if (not called)
            ToolTip "[ "
                . Trim(ih.input)
                . " ]`n`nIsn't a registered input hook."

        SetTimer ToolTip, -1000
    }

    onKeyDown(ih, vk, sc)
    {
        if (vk = 8) ; Backspace
            onChar(ih, "")
        else if (vk = GetKeyVK("Enter"))
            ih.stop()
    }

}