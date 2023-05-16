#Include "./setup.ahk"
#Include ../google-translate/methods.ahk
#Include run-list.ahk

RIH := RegisterInputHook

RIH("set admin")
ih_set_admin()=>Run('*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"')

; RIH("cls sb")
; ih_cls_sb()=>ProcessClose("SoundBooster.exe")


RIH("cls*")
ih_cls(cmd){
    if(run_list.Has(cmd) and Type(run_list[cmd]) = "Array")
        ProcessClose(run_list[cmd][1])
    else
        MsgBox "closing [" cmd "] `n`nCommand Error: not registered",,"T20"
}

RIH("run*")
ih_run(cmd){
    if(run_list.Has(cmd))
        if (Type(run_list[cmd]) = "Array")
            ih_cmd(run_list[cmd][2])
        else
            ih_cmd(run_list[cmd])
    else
        ih_cmd(cmd)
}

RIH("cmd*")
ih_cmd(cmd){
    cmd := RegExReplace(cmd, "\.? *(\n|\r)+", "")
    Try Run Trim(cmd)
    Catch as e
        MsgBox "Command: " . cmd . "`n`nError:`n`n" . e.Message,,"T20"
}

RIH("tr*")
ih_tr(phrase)=>GoogleTranslate.Translate(phrase)
