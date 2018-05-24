#!/bin/bash
export DISPLAY=:0
unclutter &
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences
/usr/bin/chromium-browser --noerrordialogs --kiosk --window-position=0,0 localhost/cgi-bin/firstTimeConfiguration.pl --disable-translate
