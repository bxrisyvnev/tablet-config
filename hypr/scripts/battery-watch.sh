#!/bin/bash

while true; do
	LEVEL=$(grep -oE '[0-9]+' /sys/class/power_supply/BAT0/capacity)

	if [ "$LEVEL" -le 30 ]; then
		./warning.sh
	fi

	sleep 120
done
