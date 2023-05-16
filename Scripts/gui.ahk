MyGui := Gui()
URL := MyGui.Add("Edit", "w930 r1", "https://www.autohotkey.com/docs/")
!#F12::
{
    MyGui.Add("Button", "x+6 yp w44 Default", "Go").OnEvent("Click", ButtonGo)
    WB := MyGui.Add("ActiveX", "xm w980 h640", "Shell.Explorer").Value
    ComObjConnect(WB, WB_events)  ; Connect WB's events to the WB_events class object.
    MyGui.Show()
    ; Continue on to load the initial page:
    ButtonGo()
    
    ButtonGo(*) {
        WB.Navigate(URL.Value)
    }
    
}
class WB_events {
        static NavigateComplete2(wb, &NewURL, *) {
            URL.Value := NewURL  ; Update the URL edit control.
        }
    }