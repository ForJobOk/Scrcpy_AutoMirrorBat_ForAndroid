adb disconnect

for /F "usebackq delims=" %%s in (`adb shell "ifconfig wlan0 | grep 'inet addr:' | sed -e 's/^.*inet addr://' -e 's/ .*//'"`) DO set ip=%%s
echo %ip%
adb tcpip 5555
adb connect %ip%:5555
adb devices

choice /c YN /m "Did you connect successfully? If the connection is successful, disconnect the cable."
@echo off
if errorlevel 2 goto :no
if errorlevel 1 goto :yes

:no
echo Terminate the connection. Make sure to connect and restart bat.
pause
exit /b

:yes
echo Start five second later.

cd "Your directory \scrcpy-win64-v1.10"

:LOOP
    timeout /T 5 > NUL
    adb wait-for-device
    scrcpy -s %ip%:5555 -c 1000:1000:110:220 
goto :LOOP