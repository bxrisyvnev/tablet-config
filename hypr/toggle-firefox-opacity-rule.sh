#!/bin/bash

CONF="$HOME/.config/hypr/hyprland.conf"

# Check if line is commented
if grep -E '^[[:space:]]*#.*windowrulev2[[:space:]]*=[[:space:]]*opacity[[:space:]]*0\.9[[:space:]]*0\.9,[[:space:]]*class:\^\(firefox\)\$' "$CONF" >/dev/null; then
	# Uncomment it
	sed -i -E \
		's/^[[:space:]]*#([[:space:]]*windowrulev2[[:space:]]*=[[:space:]]*opacity[[:space:]]*0\.9[[:space:]]*0\.9,[[:space:]]*class:[[:space:]]*\^\(firefox\)\$[[:space:]]*)/\1/' \
		"$CONF"
	echo "Firefox opacity rule ENABLED."
else
	# Comment it
	sed -i -E \
		's/^[[:space:]]*(windowrulev2[[:space:]]*=[[:space:]]*opacity[[:space:]]*0\.9[[:space:]]*0\.9,[[:space:]]*class:[[:space:]]*\^\(firefox\)\$[[:space:]]*)/#\1/' \
		"$CONF"
	echo "Firefox opacity rule DISABLED."
fi

hyprctl reload
