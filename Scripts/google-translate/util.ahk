
jsObj(){
    static doc := ComObject("htmlfile")
        ,__ := doc.write('<meta http-equiv="X-UA-Compatible" content="IE=9">')
        ,JS := doc.parentWindow
    Return JS
}

JsonToAHK(json, rec := false) {
    js := jsobj()
    ; 0x800A01B6
    ; res := js.JSON.parse(json)
    res := js.eval("(" . json . ")")
    for x in [js.JSON.parse(json)]
        ; 0x800A138A
        MsgBox js.JSON.parse(json).toString()
    ; js.alert(js.Object.prototype.toString.call(res))
    if !rec
        obj := JsonToAHK(js.eval("(" . json . ")"), true)
    else if !IsObject(json)
        obj := json
    else if js.Object.prototype.toString.call(json) == "[object Array]" {
        obj := []
        Loop json.length
            obj.Push( JsonToAHK(json[A_Index - 1], true) )
    }
    else {
        obj := {}
        keys := js.Object.keys(json)
        Loop keys.length {
            k := keys[A_Index - 1]
            obj[k] := JsonToAHK(json[k], true)
        }
    }
    Return obj
}
