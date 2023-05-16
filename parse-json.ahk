#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

FileRead, input, test.json

obj := new JSONData(input) ; create a new instance of JSONData class
if (ErrorLevel) {
    MsgBox, 64,, ErrorLevel
    return
}
arr := {}


arrCnt(arr){
    cnt = 0
    for t, q in arr
        cnt++
    return cnt
}
sendNeXt(){
    global arr
    for t, q in arr
    {
        ; MouseGetPos x, y
        ; cn := Control_GetClassNN(ControlHWNDAt(x, y))
        ; ControlGetText, x, %cn%, A
        ; ControlGet o, list, count, %cn%, A
        ; msgbox % cn . ": " . o

        ; return
        Sleep, 200
        Send, % t
        KeyWait, control, D
        Send, {Enter}
        Sleep, 200
        Send %q%
        Sleep, 200
        Send {Enter}{Enter}
        Sleep, 200
        arr.Delete(t)
        sendNeXt()
        break
    }
}
z::
    enum := new JSONData.Enumerator((obj.data.array))
    while (enum.next(k, v)) {
        arr[v.title] := v.qty
    }
    sendNeXt()
return
; ===== ===== ===== ===== ===== ===== ===== ===== =====

Class JSONData {
    Init() {
        static __ := JSONData.Init()
        (JSONData.oHTML:=ComObjCreate("HTMLFile")).write("<!DOCTYPE html><html><head><meta http-equiv=""X-UA-Compatible"" content=""IE=edge""><meta charset=""utf-8"" /><title>HTMLFile</title><script>var JSONData = new Array();</script></head><body></body></html>")
    }
    __New(__str) {
        static __i := -1
        try {
            (JSONData.oHTML.parentWindow.JSONData)[ this.index:=++__i ] := JSONData.parse(__str)
        } catch {
            return false, ErrorLevel:="ERROR_PARSE_ERROR"
        }
        return this
    }
    parse(__str) {
        return JSONData.oHTML.parentWindow.JSON.parse(__str)
    }
    data[__args*] {
        get {
            return (JSONData.oHTML.parentWindow.JSONData)[ this.index ]
        }
        set {
            (JSONData.oHTML.parentWindow.JSONData)[ this.index ] := value
        }
    }
    Class Enumerator {
        i := -1
        __New(__obj) {
            try this.count := (this.keys:=JSONData.oHTML.parentWindow.Object.keys(this.object:=__obj).slice()).length
        }
        next(ByRef __k:="", ByRef __v:="") {
            if (++this.i < this.count) {
                __k := (this.keys)[ this.i ], __v := (this.object)[__k]
                return true
            } return false, this.i:=-1
        }
    }
}
