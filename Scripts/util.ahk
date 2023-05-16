class Util{
    static getSelectedText(reset:=true){
        oCB := ClipboardAll
        A_Clipboard := ""
        Send "^c"
        ClipWait 1
        phrase := A_Clipboard
        if (not reset)
            Return phrase
        ClipBoard := oCB

        Return phrase
    }

    static exec(f0,f1:=0,f2:=0,
    f3:=0,f4:=0,f5:=0,
    f6:=0,f7:=0,f8:=0,f9:=0
    ){
        loop 10
            if (f%(A_Index-1)%)
                %"f" A_Index-1%()
    }
}