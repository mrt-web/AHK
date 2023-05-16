
SetKeyDelay 50

!1::
    send 5482741266144729{Tab}
    send 0125{Tab}
    send 643{Tab}
    send eg{Tab}
    sleep 1000

    send Mohamed{Tab}
    send Tarabia{Tab}
    send Addr.1{Tab 2}
    send Addr.city{Tab 3}
    send 1121102698{Tab}
    send quixet.3@gmail.com{Tab 4}
return


^!s:: 
    Send ^s
    Reload
return

^!q::
    msgbox ,,Closing, PayPal debit input .. is Closing!, 2
    ExitApp
return