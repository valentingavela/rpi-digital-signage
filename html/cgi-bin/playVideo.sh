#!/bin/bash
cd /var/www/ &&
/usr/bin/omxplayer $1 < /var/www/omxplayerpipe &
/bin/echo . > /var/www/omxplayerpipe &
