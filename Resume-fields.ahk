
SetKeyDelay 50

!9::
    send Mohamed{Tab}
    send Tarabia{Tab}
    send iquixe@gmail.com{Tab}
    send `{+}0201097207563{Tab}

    send Egypt{Tab}Damietta{Tab}Damietta{Tab}23712
    send {Tab}{Enter}{Tab 2}{Enter}
    sleep 500
    send laborer.docx{enter}
    sleep 150

    send {Tab}{Down 2}
    send {Tab}{Down 1}
    send {Tab}{Down 1}
    send {Tab}{Down 1}
return
!3::
    send {down 2}{Tab}
    send Mohamed{Tab 2}
    send Tarabih{Tab 2}
    send Egypt{Tab}
    send Egypt{Tab 2}
    send Damietta{Tab}
    sleep 200
    send du{enter}{Tab}
    sleep 200
    send Damietta{Tab}
    send 23714{Tab}
    send {down}{Tab}
    send eg{enter}{Tab}
    send 01097207563{Tab 3}
    send o{enter}{Tab 2}
    sleep 200
    send iquixe@gmail.com{Tab 2}
return
sf(){
    click
    sleep 1200
    Send {Enter}{Tab 10}30000{Tab 2}No
    sleep 1200
    Send {Enter}{Tab 3}Yes
    sleep 1200
    Send {Enter}{Tab}No
    sleep 1200
    Send {Enter}{Tab}No
    sleep 1200
    Send {Enter}{Tab}No
    sleep 1200
    Send {Enter}{Tab}all
    Send {Tab}{Space}
    Send {Tab 2}{Enter}
    ; Sleep 1000
    Send ^{Tab}
    SoundBeep, 750, 500
    sleep 1000
}
shrt1(){
    click
    send iquixe@gmail.com{Enter}
}
shrt2(){
    click
    send Mohamed{Tab}
    send Tarabia{Tab}
    send {+}201097207563{Tab}{space}{enter}
}
rimi(){
    click
    send {Tab}Mohamed{Tab}Tarabia{Tab}
    send iquixe@gmail.com{Tab}
    send {Numpadadd}20{Tab}1097207563{Tab 2}
    send eg{Tab 2}{space}
    sleep 1200
    send sales.pdf{Enter}
    sleep 1200
    send {Tab 3}{space}
    sleep 1200
    send sales-cover.pdf{Enter}
    sleep 1200
}


dirbam(){
    click
    send Mohamed{Tab}
    send iquixe@gmail.com{Tab}
    send {+}201097207563{Tab}
}

BooClck(){
    loop , 200
    {
        click
        sleep 500
        Send ^v
        sleep 1500
        Send {Enter}
    }
}

!1:: BooClck()

!2:: shrt2()
^!1::
    rimi()
    SoundBeep, 750, 500
return




!^2::
        sf()

return
!4::
    send {down 5}{enter}
    sleep 300
    send {tab 4}
    sleep 300
    send n{enter}{tab 2}
    sleep 300
    send e{enter}{tab 3}
    sleep 300
    send a{enter}{tab 2}
return

^!r:: 
    Send ^s
    Reload
return