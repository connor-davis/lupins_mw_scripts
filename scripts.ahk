ChangeSilentShotLethalKey(*) {
    global SilentShotKey

    o := g_LMWS.Submit("0")
    SilentShotKey := o.SilentShotKey
}

ChangeSlideCancelActivatorKey(*) {
    global SlideCancelActivatorKeybind

    o := g_LMWS.Submit("0")
    SlideCancelActivatorKeybind := o.SlideCancelActivatorKey
}

ChangeSlideCancelSlideKey(*) {
    global SlideCancelSlideKeybind

    o := g_LMWS.Submit("0")
    SlideCancelSlideKeybind := o.SlideCancelSlideKey
}

ChangeSlideCancelJumpKey(*) {
    global SlideCancelJumpKeybind

    o := g_LMWS.Submit("0")
    SlideCancelJumpKeybind := o.SlideCancelJumpKey
}

ApplyChanges(*) {
    IniWrite(SilentShotKey, A_MyDocuments "\LMWS\config.ini", "Silent Shot", "key")
    IniWrite(SlideCancelActivatorKeybind, A_MyDocuments "\LMWS\config.ini", "Slide Cancel", "activatorKey")
    IniWrite(SlideCancelSlideKeybind, A_MyDocuments "\LMWS\config.ini", "Slide Cancel", "slideKey")
    IniWrite(SlideCancelJumpKeybind, A_MyDocuments "\LMWS\config.ini", "Slide Cancel", "jumpKey")

    GuiCtrlFromHwnd(g_LMWS_StatusBar.Hwnd).Text := "Changes have been saved."

    Sleep(1000)

    GuiCtrlFromHwnd(g_LMWS_StatusBar.Hwnd).Text := ""
}

SilentShotCheckboxChanged(*) {
    o := g_LMWS.Submit("0")

    toggleSilentShot()
}

RapidFireCheckboxChanged(*) {
    o := g_LMWS.Submit("0")

    toggleRapidFire()
}

SlideCancelCheckboxChanged(*) {
    o := g_LMWS.Submit("0")

    toggleSlideCancel()
}

SilentShotScript(*) {
    If (WinActive("ahk_exe ModernWarfare.exe")) {
        Send("{Lbutton down}")
        Sleep(5)
        Send("{Lbutton up}")
        Sleep(5)
        Send("{" SilentShotKey "}")
        Sleep(25)
        Send("{1 down}")
        Sleep(5)
        Send("{1 up}")
        Sleep(5)
        Send("{RButton up}")
    }
}

RapidFireScript(*) {
    If (WinActive("ahk_exe ModernWarfare.exe")) {
        While GetKeyState("LButton", "P") {
            MouseClick("Left")
            Sleep(50)
        }
    }
}

SlideCancelScript(*) {
    If (WinActive("ahk_exe ModernWarfare.exe")) {
        Send("{" SlideCancelSlideKeybind " down}")
        Sleep(80)
        Send("{" SlideCancelSlideKeybind " up}")
        Sleep(80)
        Send("{" SlideCancelSlideKeybind " down}")
        Sleep(80)
        Send("{" SlideCancelSlideKeybind " up}")
        Sleep(60)
        Send("{" SlideCancelJumpKeybind " down}")
        Sleep(120)
        Send("{" SlideCancelJumpKeybind " up}")
        Sleep(120)
        Send("{" SlideCancelSprintKeybind "}")
    }
}

toggleSilentShot() {
    global silentShotEnabled
    global rapidFireEnabled

    If (WinActive("ahk_exe ModernWarfare.exe")) {
        if (silentShotEnabled = 0) {
            Hotkey("LButton", SilentShotScript, "Off")
            Hotkey("LButton", RapidFireScript, "Off")

            Hotkey("LButton", SilentShotScript, "On")

            silentShotEnabled := 1
            rapidFireEnabled := 0

            SoundBeep 1000
            SoundBeep 500
        }
        else {
            Hotkey("LButton", SilentShotScript, "Off")
            Hotkey("LButton", RapidFireScript, "Off")

            silentShotEnabled := 0

            SoundBeep 500
            SoundBeep 1000
        }
    }
}

toggleRapidFire() {
    global rapidFireEnabled
    global silentShotEnabled

    If (WinActive("ahk_exe ModernWarfare.exe")) {
        if (rapidFireEnabled = 0) {
            Hotkey("LButton", SilentShotScript, "Off")
            Hotkey("LButton", RapidFireScript, "Off")

            Hotkey("LButton", RapidFireScript, "On")

            rapidFireEnabled := 1
            silentShotEnabled := 0

            SoundBeep 1000
            SoundBeep 500
            SoundBeep 1000
        }
        else {
            Hotkey("LButton", SilentShotScript, "Off")
            Hotkey("LButton", RapidFireScript, "Off")

            silentShotEnabled := 0

            SoundBeep 500
            SoundBeep 1000
            SoundBeep 500
        }
    }
}

toggleSlideCancel() {
    global slideCancelEnabled

    If (WinActive("ahk_exe ModernWarfare.exe")) {
        if (slideCancelEnabled = 0) {
            Hotkey(SlideCancelActivatorKeybind, SlideCancelScript, "Off")
            Hotkey(SlideCancelActivatorKeybind, SlideCancelScript, "On")

            slideCancelEnabled := 1

            SoundBeep 1000
            SoundBeep 500
            SoundBeep 1000
            SoundBeep 500
        }
        else {
            Hotkey(SlideCancelActivatorKeybind, SlideCancelScript, "Off")

            slideCancelEnabled := 0

            SoundBeep 500
            SoundBeep 1000
            SoundBeep 500
            SoundBeep 1000
        }
    }
}

disableAll() {
    global silentShotEnabled
    global rapidFireEnabled
    global slideCancelEnabled

    If (WinActive("ahk_exe ModernWarfare.exe")) {
        SoundBeep 1000
        SoundBeep 500
        SoundBeep 1000
        SoundBeep 500
        SoundBeep 1000

        silentShotEnabled := 0
        rapidFireEnabled := 0
        slideCancelEnabled := 0

        Hotkey("LButton", SilentShotScript, "Off")
        Hotkey("LButton", RapidFireScript, "Off")
        Hotkey("C", SlideCancelScript, "Off")
    }
}