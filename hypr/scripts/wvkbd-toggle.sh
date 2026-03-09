#!/bin/sh

if pgrep -x "wvkbd-mobintl" > /dev/null; then
	killall wvkbd-mobintl
else
	wvkbd-mobintl -H 360 -L 300 --fn "Sans 24" &
fi
