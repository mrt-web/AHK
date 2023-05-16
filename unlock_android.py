import os
from subprocess import run, PIPE, Popen, check_output

phone_pass = '3333'

def call(command: str):
    args = [f'adb {command}', '']
    args = ['adb', *command.split(' ')]
    return Popen(args, stdout=PIPE)

def shell(command: str):
    # commented methods should work fine
    # return os.system('adb shell ' + command)

    args = ['adb', 'shell ' + command]
    return check_output('adb shell ' + command, shell=True)
    # return run('adb shell ' + command, shell=True)

    # proc = Popen(args, stdout=PIPE, stderr=PIPE, shell=True)
    # out, err = proc.communicate()
    # proc.returncode
    # return out
    # return run(args, stdout=PIPE, shell=True)   # ran on windows
    

power_info = lambda : str(shell('dumpsys power')).replace('\\r\\n', '$$$').split('$$$')

lock_state = 'dumpsys power'
lck_btn = 'input keyevent 26'
unlock = 'input keyevent 82'
swipe = 'input touchscreen swipe 930 880 930 80'
pin = 'input text ' + phone_pass
enter = 'input keyevent 66'

def includes(val, _list):
    repeats = len(list(
        filter(lambda e: val in e, _list)
    )) 
    return repeats > 0

def is_unlocked():
    return includes('mUserActivityTimeoutOverrideFromWindowManager=-1', power_info())

def is_awake():
    test_awakness = includes('mWakefulness=Awake', power_info())
    return test_awakness

def waken(retry = True):
    if not is_awake():
        shell(lck_btn)
    else: return True

    if retry and not is_awake():
        for i in range(5):
            if waken(False): return True
    return True if is_awake() else  False
        

def lock_phone():
    if is_awake():
        shell(lck_btn)
        print('Succesfully locked')
    else: print('ERR:APPEARS_LOCKED')

def unlock_phone():
    if not waken():
        print('ERR:FAILED_TO_AWAKEN')
        return False
    if not is_unlocked():
        shell(swipe)
        shell(pin)
        print('Succesfully unlocked')
    else: print('ERR:ALREADY_UNLOCKED')

def connect_tcp():
    run ('adb tcpip 5555', stdout=PIPE, shell=True)
    run ('adb connect 192.168.1.202:5555', stdout=PIPE, shell=True)

import sys
if __name__ == "__main__" and len(sys.argv) > 1:
#    print('processing arguments:', sys.argv[1:])
   if sys.argv[1] == 'unlock':
       unlock_phone()
   if sys.argv[1] == 'lock':
       lock_phone()
   if sys.argv[1] == 'swipe':
       shell(swipe)
   if sys.argv[1] == 'tcp':
       connect_tcp()
   if sys.argv[1] == 'connect':
       connect_tcp()
    



# r = os.system('adb shell input keyevent 26')
# r = os.system('adb shell dumpsys power')
# print('ran', r)

# adb shell ps  # list all android process
# adb shell pm clear com.package.name   # resets app storage
# adb shell am force-stop com.package.name   # stops app
# adb shell am start -n com.package.name     # start app
# adb shell am start -n com.package.name/com.package.name.ActivityName      # start with target intent
# am start -a com.example.ACTION_NAME -n com.package.name/com.package.name.ActivityName # specify actions to be filter by your intent-filters

# List all intents of an app:
# adb shell  dumpsys package com.whatsapp | grep -i  activity | awk 'NF{NF-=1};1' |  sort |  uniq
# adb shell dumpsys package | grep -Eo "^[[:space:]]+[0-9a-f]+[[:space:]]+com.android.chrome/[^[:space:]]+" | grep -oE "[^[:space:]]+$"
# adb shell pm dump com.android.chrome | grep ' filter' | cut -d ' ' -f 12 | sort | uniq

# adb shell pm list packages    # list all installed apps
# adb shell am start com.miui.calculator
# adb shell monkey -p com.miui.calculator 1  #launch the default activity for the package that is in the launcher.

# get active activity
# adb shell "dumpsys activity | grep top-activity"
