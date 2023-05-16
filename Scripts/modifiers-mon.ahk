ModifiersDown := Map(
"ALT", False,
"SHIFT", False,
"CTRL", False
)
ModifierMon(mod, down := True){
    global ModifiersDown
    mod := StrUpper(mod)
    ModifiersDown[mod] := down

    msg := "Modifiers Down:`n"
    downCount := 0

    For Key, Value in ModifiersDown
        if (Value) {
            downCount += 1
            msg .= "`n" . Key
        }

    if (downCount > 0)
        Return ToolTip(msg, 0, 0, 20)

    CoordMode "ToolTip", "Screen"
    ToolTip("",,,20)
}

~ALT::ModifierMon("ALT", True)
~ALT Up::ModifierMon("ALT", False)

~CTRL::ModifierMon("CTRL", True)
~CTRL Up::ModifierMon("CTRL", False)

~SHIFT::ModifierMon("SHIFT", True)
~SHIFT Up::ModifierMon("SHIFT", False)