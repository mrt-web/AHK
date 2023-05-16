#Requires AutoHotkey v2.0-beta

; ###############################
; ######## Quran Flash ##########

QFApp := "ahk_class ApolloRuntimeContentWindow"

; Down arrow
#HotIf WinActive(QFApp) && isZoomed
Down UP::SendEvent "{Click 200 900 Down}{click 200 300 Up}"
#HotIf WinActive(QFApp) && isZoomed
WheelDown::SendEvent "{Click 200 600 Down}{click 200 300 Up}"

; Up arrow
#HotIf WinActive(QFApp) && isZoomed
Up UP::SendEvent "{Click 200 300 Down}{click 200 900 Up}"
#HotIf WinActive(QFApp) && isZoomed
WheelUp::SendEvent "{Click 200 300 Down}{click 200 600 Up}"

#HotIf WinActive(QFApp)
NumpadAdd::QF__Zoom(, True)
#HotIf WinActive(QFApp)
MButton::QF__Zoom(, True)

; Left arrow
#HotIf WinActive(QFApp) && isZoomed
Left::QF__Zoom()
#HotIf WinActive(QFApp) ; && isZoomed
^Left::QF__flip(True)
#HotIf WinActive(QFApp)
XButton1::QF__Zoom()
#HotIf WinActive(QFApp)
^XButton1::QF__flip(True)

; Right arrow
#HotIf WinActive(QFApp) && isZoomed
Right::QF__Zoom(False)
#HotIf WinActive(QFApp) ;&& isZoomed
^Right::QF__flip(True, False)
#HotIf WinActive(QFApp)
XButton2::QF__Zoom(False)
#HotIf WinActive(QFApp)
^XButton2::QF__flip(True, False)

; NumPad -, +, Esc
#HotIf WinActive(QFApp)
NumpadSub::QF__Zoomout()
#HotIf WinActive(QFApp)
Esc::QF__Zoomout()
#HotIf WinActive(QFApp)
RButton::QF__Zoomout()

global CurPage := 0
global isZoomed := False
global tickCount := 0

QF__GetElapsedTime(){
    global tickCount

    if(tickCount > 0){
        elapsedSecs := (A_TickCount - tickCount) // 1000
        min := elapsedSecs // 60
        sec := elapsedSecs - min * 60

        ToolTip "Time Elapsed Since Last Flip `n TELF => " min ":" sec " ", 0, 0
        SetTimer () => ToolTip(), -5000
    }

    tickCount := A_TickCount
}

QF__Zoom(forward := True, again := False){
    xPos := [1200, 700]
    global CurPage, isZoomed
    CoordMode "Mouse", "Screen"

    QF__GetElapsedTime()

    QF__Zoomout()
    if(not again) ; otherwise zoom the last zoomed page
        QF__SetNextIndex(forward)

    Click 700, 70
    Sleep 50

    CurPage := CurPage ? CurPage : 1
    Click xPos[CurPage], 400
    isZoomed := True

    MouseMove 700, 270
    sleep 1500
    Click 700, 270
}

QF__Zoomout(){
    global isZoomed
    Send "{Esc}"
    if (isZoomed)
        sleep 600
    isZoomed :=False
}

QF__SetNextIndex(forward := True){
    global CurPage
    if (CurPage == 0){
        CurPage := forward ? 1 : 2
        forward := CurPage == 1 ? 2 : forward ; 2 to cancel flipping
    }
    else if (CurPage == 1)
        CurPage := 2
    else if(CurPage == 2)
        CurPage := 1

    QF__flip(, forward)
}

QF__flip(forceFlip := False, forward := True){
    global CurPage

    if(forceFlip || (CurPage==1 && forward==1) || (CurPage==2 && forward==0)){
        if(forceFlip){
            QF__Zoomout()
            CurPage := 0
        }
        send forward ? "{left}" : "{right}"
        sleep 600
    }

}

