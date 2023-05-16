#Include ./methods.ahk

; =================== Hotkeys ===================

GT := GoogleTranslate

; #HotIf not WinActive("ahk_exe chrome.exe")
; F12::GT.TranslateInput() ; Inputbox to enter text to translate
; #HotIf WinActive("ahk_exe chrome.exe")
; ^F12::GT.TranslateInput()

RobloxSafe := ()=> not WinActive("ahk_exe RobloxPlayerBeta.exe")

; Translate selected text
#HotIf RobloxSafe()
~LButton & WheelDown::{
    GT.TranslateSelection()

    if (!GetKeyState('LButton', 'P'))
        GT.HideTranslation()
}

; Release translation Tooltip
#HotIf GT.isVisible && RobloxSafe()
LButton Up::{
    Send "{Click Up}"
    GT.HideTranslation()
}
