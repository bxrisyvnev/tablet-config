#!/usr/bin/env python3
# Detect 3-finger swipe down on Wacom touchscreen

from evdev import InputDevice, categorize, ecodes, AbsInfo, list_devices
import time
import subprocess

# Change to your touchscreen device
TOUCHSCREEN_PATH = "/dev/input/event5"

dev = InputDevice(TOUCHSCREEN_PATH)
print(f"Listening on {dev.name} ({TOUCHSCREEN_PATH})...")

fingers = {}
last_time = time.time()

def reset_fingers():
    global fingers
    fingers = {}

def run_script():
    subprocess.Popen(['/home/boris/.config/hypr/scripts/wvkbd-toggle.sh'])

for event in dev.read_loop():
    if event.type == ecodes.EV_ABS:
        if event.code == ecodes.ABS_MT_TRACKING_ID:
            if event.value == -1:
                # Finger lifted
                fingers.pop(event.slot, None)
            else:
                # Finger placed
                fingers[event.slot] = {'start': None, 'y': 0}
        if event.code == ecodes.ABS_MT_POSITION_Y:
            # Track vertical movement
            fingers[event.slot]['y'] = event.value

    elif event.type == ecodes.EV_SYN and event.code == ecodes.SYN_REPORT:
        if len(fingers) == 3:
            ys = [f['y'] for f in fingers.values()]
            if all(y > 1000 for y in ys):  # crude swipe down detection
                # Only trigger once every 1s
                if time.time() - last_time > 1:
                    run_script()
                    last_time = time.time()
                reset_fingers()
