#!/bin/bash
apt update &&
cpan HTML::Template &&
cpan JSON &&
apt install unclutter &&
mkfifo /var/www/omxplayerpipe &&
chown www-data:www:data /var/www/omxplayerpipe &&
usermod -a -G video www-data &&
usermod -a -G audio www-data &&

cp config_autostart/boot_cmdline.txt /boot/cmdline.txt
cp config_autostart/home_pi_config_autostart /home/pi/.config/lxsession/LXDE-pi/autostart
cp config_autostart/config.txt /boot/config.txt

#LINKS
ln -s /home/pi/rpi-digital-signage/home/kiosk.sh /home/pi/kiosk.sh
ln -s /home/pi/rpi-digital-signage/home/monitor.pl /home/pi/monitor.pl
ln -s /home/pi/rpi-digital-signage/home/siguit.pem /home/pi/siguit.pem
ln -s /home/pi/rpi-digital-signage/home/synchro.pl /home/pi/synchro.pl
ln -s /home/pi/rpi-digital-signage/home/syncSystem.pl /home/pi/syncSystem.pl

ln -s /home/pi/rpi-digital-signage/html/siguitds/ /var/www/html/siguitds
ln -s /home/pi/rpi-digital-signage/html/css/styles-messages.css /var/www/html/css/styles-messages.css
ln -s /home/pi/rpi-digital-signage/html/templates/ /var/www/html/templates

ln -s /home/pi/rpi-digital-signage/html/cgi-bin/dis_number.txt /var/www/html/cgi-bin/dis_number.txt
# ln -s /home/pi/rpi-digital-signage/html/cgi-bin/play2.pl /var/www/html/cgi-bin/play2.pl
ln -s /home/pi/rpi-digital-signage/html/cgi-bin/play3.pl /var/www/html/cgi-bin/play3.pl
ln -s /home/pi/rpi-digital-signage/html/cgi-bin/playVideo.pl /var/www/html/cgi-bin/playVideo.pl
ln -s /home/pi/rpi-digital-signage/html/cgi-bin/playVideo.sh /var/www/html/cgi-bin/playVideo.sh
ln -s /home/pi/rpi-digital-signage/html/cgi-bin/videoProcess.pl /var/www/html/cgi-bin/videoProcess.pl
ln -s /home/pi/rpi-digital-signage/html/firstTimeConfiguration /var/www/html/

chmod o+w /etc/wpa_supplicant/wpa_supplicant.conf
