#!/usr/bin/env bash

CONF="$HOME/.config/hypr/hyprland.conf"
RULE="windowrule = match:class ^(firefox)$, opacity 0.9 0.9"
COMMENTED="#$RULE"

# Case 1: commented line exists → uncomment it
if grep -q "^$COMMENTED" "$CONF"; then
	sed -i "s|^$COMMENTED|$RULE|" "$CONF"
	hyprctl reload
	hyprctl notify 0 3000 "Firefox opacity rule enabled"
	exit 0
fi

# Case 2: uncommented line exists → comment it
if grep -q "^$RULE" "$CONF"; then
	sed -i "s|^$RULE|$COMMENTED|" "$CONF"
	hyprctl reload
	hyprctl notify 0 3000 "Firefox opacity rule disabled"
	exit 0
fi

# Case 3: no matching rule found
hyprctl notify 1 3000 "Firefox opacity rule not found"
exit 1
