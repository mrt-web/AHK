; Simple auto-complete: any day of the week. Pun aside, this is a mostly functional example. Simply run the script and start typing today, press Tab to complete or press Esc to exit

WordList := "xMonday`nxTuesday`nxWednesday`nxThursday`nxFriday`nxSaturday`nxSunday"

Suffix := ""

SacHook := InputHook("V", "{Esc}")
SacHook.OnChar := SacChar
SacHook.OnKeyDown := SacKeyDown
SacHook.KeyOpt("{Backspace}", "N")
SacHook.Start()

SacChar(ih, char)  ; Called when a character is added to SacHook.Input.
{
    ; msgbox "chardown, " . char
    global Suffix := ""
    if RegExMatch(ih.Input, "`nm)\w+$", &prefix)
        && RegExMatch(WordList, "`nmi)^" prefix[0] "\K.*", &Suffix)
        Suffix := Suffix[0]
    
    if CaretGetPos(&cx, &cy)
        ToolTip Suffix, cx + 15, cy
    else
        ToolTip Suffix

    ; Intercept Tab only while we're showing a tooltip.
    ih.KeyOpt("{Tab}", Suffix = "" ? "-NS" : "+NS")
}

SacKeyDown(ih, vk, sc)
{
    ; msgbox "keydown, " . Suffix . vk
    if (vk = 8) ; Backspace
        SacChar(ih, "")
    else if (vk = 9) ; Tab
        Send "{Text}\" Suffix "\"
}
