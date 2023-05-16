run_list := Map(
; cmd, [process, path] or path
"chrome", "C:\Program Files\Google\Chrome\Application\chrome.exe"
    , "firefox", "C:\Program Files\Mozilla Firefox\firefox.exe"
    , "diskmgmt", "C:\Windows\System32\diskmgmt.msc"
    , "devmgmt", "C:\Windows\System32\devmgmt.msc"
    , "services", "C:\Windows\System32\services.msc"
    , "eventvwr", "C:\Windows\System32\eventvwr.msc"
    , "compmgmt", "C:\Windows\System32\compmgmt.msc"
    , "perfmon", "C:\Windows\System32\perfmon.msc"
    , "gpedit", "C:\Windows\System32\gpedit.msc"
    , "calc", "C:\Windows\System32\calc.exe"
    , "paint", "C:\Windows\System32\mspaint.exe"
    , "snipping", "C:\Windows\System32\SnippingTool.exe"
    , "wordpad", "C:\Windows\System32\write.exe"
    , "word", "C:\Program Files (x86)\Microsoft Office\root\Office16\WINWORD.EXE"
    , "excel", "C:\Program Files (x86)\Microsoft Office\root\Office16\EXCEL.EXE"
    , "powerpoint", "C:\Program Files (x86)\Microsoft Office\root\Office16\POWERPNT.EXE"
    , "outlook", "C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE"
    , "access", "C:\Program Files (x86)\Microsoft Office\root\Office16\MSACCESS.EXE"
    , "skype", "C:\Program Files\WindowsApps\Microsoft.SkypeApp_15.96.3207.0_x64__kzf8qxf38zg5c\Skype\Skype.exe"
    , "discord", "C:\Users\%A_UserName%\AppData\Local\Discord\app-0.0.305\Discord.exe"
    , "pot", "C:\Program Files\DAUM\PotPlayer\PotPlayerMini64.exe"
    , "vlc", "C:\Program Files (x86)\VideoLAN\VLC\vlc.exe"

    , "git", "C:\Program Files\Git\git-bash.exe"

    ,"jd", ["JDownloader2.exe", "C:\Program Files (x86)\JDownloader 2\JDownloader2.exe"]
    ,"sb", ["SoundBooster.exe", "C:\Program Files (x86)\Letasoft Sound Booster\SoundBooster.exe"]
    ,"qb", ["qbittorrent.exe", "C:\Program Files\qBittorrent\qbittorrent.exe"]
    , "tabby", ["tabby.exe", "C:\Users\mrt\AppData\Local\Programs\Tabby\Tabby.exe"]
)

run_list.CaseSensitive := "off"
