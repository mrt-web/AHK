
;; Control my Xiaomi

^!+F9:: run python unlock_android.py tcp, %A_ScriptDir%
^!+F10:: run python unlock_android.py lock, %A_ScriptDir%
^!+F11:: run python unlock_android.py swipe, %A_ScriptDir%
^!+F12:: run python unlock_android.py unlock, %A_ScriptDir%
