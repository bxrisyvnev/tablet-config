import evdev
from evdev import UInput, ecodes, InputDevice
import threading

# Finger touchscreen device
TOUCHSCREEN_DEVICE = '/dev/input/by-id/usb-Wacom_Co._Ltd._Pen_and_multitouch_sensor-event-if00'

# Display size
SCREEN_WIDTH = 1920
SCREEN_HEIGHT = 1080

# Current rotation (0=landscape, 90=portrait, 180, 270)
current_rotation = 0

def rotate_coordinates(x, y, width, height, angle):
    if angle == 0:
        return x, y
    elif angle == 90:
        return height - y, x
    elif angle == 180:
        return width - x, height - y
    elif angle == 270:
        return y, width - x
    else:
        return x, y

def touchscreen_thread():
    device = InputDevice(TOUCHSCREEN_DEVICE)
    ui = UInput()
    abs_x, abs_y = 0, 0
    for event in device.read_loop():
        if event.type == ecodes.EV_ABS:
            if event.code == ecodes.ABS_X:
                abs_x = event.value
            elif event.code == ecodes.ABS_Y:
                abs_y = event.value
        elif event.type == ecodes.EV_SYN and event.code == ecodes.SYN_REPORT:
            rx, ry = rotate_coordinates(abs_x, abs_y, SCREEN_WIDTH, SCREEN_HEIGHT, current_rotation)
            ui.write(ecodes.EV_ABS, ecodes.ABS_X, rx)
            ui.write(ecodes.EV_ABS, ecodes.ABS_Y, ry)
            ui.write(ecodes.EV_SYN, ecodes.SYN_REPORT, 0)

threading.Thread(target=touchscreen_thread, daemon=True).start()

# Keep the script running
while True:
    pass
