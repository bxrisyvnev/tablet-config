#!/bin/bash
# ~/config/hypr/scripts/wvkbd-touchscreen.sh

# TOUCHEGG_DEVICE_TYPE is set by Touchégg automatically
# Common values: touchpad, touchscreen, unknown

if [ "$TOUCHEGG_DEVICE_TYPE" = "touchscreen" ]; then
    /home/boris/.config/hypr/scripts/wvkbd-toggle.sh
fi
