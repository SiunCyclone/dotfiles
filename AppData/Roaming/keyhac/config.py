import sys
import os.path
from keyhac import *

def configure(keymap):
    keymap.clipboard_history.maxnum = 1

    # Replace Muhenkan as U0
    keymap.replaceKey("(29)", 235)
    keymap.defineModifier(235, "User0")

    keymap_global = keymap.defineWindowKeymap()

    if os.path.exists("C:/msys64"):
        keymap_global["U0-S-Return"] = keymap.command_ShellExecute(None, "C:/msys64/msys2_shell.bat", "", "")
    elif os.path.exists("C:/msys32"):
        keymap_global["U0-S-Return"] = keymap.command_ShellExecute(None, "C:/msys32/msys2_shell.bat", "", "")
    else:
        sys.stdout.write("MSYS2 is NOT installed")

    keymap_global["U0-I"] = keymap.command_ShellExecute(None, "firefox.exe", "", "")
    keymap_global["U0-S-R"] = keymap.command_ReloadConfig

    def close():
        window = keymap.getTopLevelWindow()
        window.sendMessage(WM_SYSCOMMAND, SC_CLOSE)
    keymap_global["U0-S-D"] = close

    def toggleMaximize():
        window = keymap.getTopLevelWindow()
        if window.isMaximized():
            window.restore()
        else:
            window.maximize()
    keymap_global["U0-M"] = toggleMaximize

    # keymap_global["U0-R"] = launcher

    # Window Manipulation

    keymap_global["U0-C-Left"] = keymap.command_MoveWindow_MonitorEdge(0)
    keymap_global["U0-C-Right"] = keymap.command_MoveWindow_MonitorEdge(2)
    keymap_global["U0-C-Up"] = keymap.command_MoveWindow_MonitorEdge(1)
    keymap_global["U0-C-Down"] = keymap.command_MoveWindow_MonitorEdge(3)

    # Virtual Desktop

