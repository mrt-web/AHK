#Include '../util.ahk'
class GT__Display{
    GT__ToolTipIndex := 5
    TR__Tooltip := False

    DisplayTranslation(phrase:="", translation:="", timeout := 0){
        this.TR__Tooltip := True

        msg := "------------ From English ------------`n`n"
            . phrase
            . "`n`n------------ To Arabic ------------`n`n"
            . translation

        ToolTip msg,,, this.GT__ToolTipIndex
        SoundBeep 250, 60

        if (timeout > 0)
            Try SetTimer(this.HideTranslation, timeout)
        Catch {
            Sleep timeout*1000
            this.HideTranslation()
        }
    }

    HideTranslation(){
        this.TR__Tooltip := False
        ToolTip ,,, this.GT__ToolTipIndex
        SoundBeep 250, 60
    }

    DisplayTranslationMsg(phrase, translation, timeout := 2){
        msgBox(
        phrase .
        "`n`n-------------`n`n" .
        translation,
        "English to Arabic",
        "T2"
        )
    }
}

class GT__API{
    getIpAddress(){
        whr := ComObject("WinHttp.WinHttpRequest.5.1")
        whr.Open("GET", "https://api.ipify.org")
        whr.Send()
        Return whr.ResponseText
    }

    GetTranslation(phrase, from, to){
        a := "https://translate.googleapis.com/translate_a/single?client=gtx&sl="
        url := a . from . "&tl=" . to . "&dt=t&q=" . phrase

        WebRequest := ComObject("WinHttp.WinHttpRequest.5.1")
        WebRequest.Open("GET", url)
        WebRequest.Send()
        res := WebRequest.ResponseText
        WebRequest := ""

        ; res := jsObj().JSON.parse(res).toString()
        res := StrSplit(res, '"')
        out := ""
        for x in res
            if (A_Index == 2 || ((A_Index-2) // 8) - ((A_Index-2) / 8) == 0)
                If (A_Index < res.Length - 1)
                    out := out . x "`n`n"
        return out
    }
}

class GoogleTranslate{

    static display := GT__Display()
    static api := GT__API()

    static isVisible{
        get => this.display.TR__Tooltip
        ; set => this.display.TR__Tooltip := value
    }

    static HideTranslation(){
        this.display.HideTranslation()
    }

    static TranslateInput(){
        phrase := InputBox("Enter text to translate", "English to Arabic", 'w40 h120', "phrase").Value
        transaltion := this.API.GetTranslation(phrase, "en", "ar")
        this.Display.DisplayTranslation(phrase, transaltion)
    }

    static TranslateSelection(timeout := 0){
        phrase := Util.getSelectedText()
        transaltion := this.API.GetTranslation(phrase, "en", "ar")
        this.Display.DisplayTranslation(phrase, transaltion, timeout)
    }

    static Translate(phrase, timeout := 2){
        transaltion := this.API.GetTranslation(phrase, "en", "ar")
        this.Display.DisplayTranslation(phrase, transaltion, timeout)
    }
}