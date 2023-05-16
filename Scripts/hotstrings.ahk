; HotStrings Options:
; -------------------
/*
    C/C1 : Case sensitive/insensitive
    b0/b1 : auto-delete the hotstring after sending
    s0/s1 : auto-space after sending
    * : don't wait for a space|tab|enter after the hotstring
    X : execute a procedure not replace text
*/
; ? : execute even if is part of other word

; Hotstrings Shortcut conventions:
; --------------------------------
/*
    [:set {options}] => set
    [:tg {options}] => toggle
    [:run {options}] => run
    [:cls {options}] => close

*/

:?*:`:run` s::{
    ProcessClose("SoundBooster.exe")
}
:?*:`:run` b::{
    Run("C:\Program Files (x86)\Letasoft Sound Booster\SoundBooster.exe")
}

; :*:ss::test
; testLc :run s :run

; InputHooks
+^!a:: {
    CtrlC := Chr(3) ; Store the character for Ctrl-C in the CtrlC var.
    ih := InputHook("L1 M")
    ih.Start()
    ih.Wait()
    MsgBox ih.input
    ; if (ih.Input = CtrlC)
    ;     MsgBox "You pressed Control-C."
}

