Application := "ModernWarfare"

ChangeSilentShotLethalKey(*) {
    global SilentShotKey

    o := g_LMWS.Submit("0")
    SilentShotKey := o.SilentShotKey
}

; ChangeRechamberCancelKey(*) {
;     global RechamberCancelKey

;     o := g_LMWS.Submit("0")
;     RechamgerCancelKey := o.RechamberCancelKey
; }

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

ChangeSlideCancelCancelKey(*) {
    global SlideCancelCancelKeybind

    o := g_LMWS.Submit("0")
    SlideCancelCancelKeybind := o.SlideCancelCancelKey
}

ApplyChanges(*) {
    IniWrite(SilentShotKey, A_MyDocuments "\LMWS\config.ini", "Silent Shot", "key")
    ; IniWrite(RechamberCancelKey, A_MyDocuments "\LMWS\config.ini", "Rechamber Cancel", "key")
    IniWrite(SlideCancelActivatorKeybind, A_MyDocuments "\LMWS\config.ini", "Slide Cancel", "activatorKey")
    IniWrite(SlideCancelSlideKeybind, A_MyDocuments "\LMWS\config.ini", "Slide Cancel", "slideKey")
    IniWrite(SlideCancelCancelKeybind, A_MyDocuments "\LMWS\config.ini", "Slide Cancel", "cancelKey")

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

; RechamberCancelCheckboxChanged(*) {
;     o := g_LMWS.Submit("0")

;     toggleRechamberCancel()
; }

SilentShotScript(*) {
    If (WinActive("ahk_exe " Application ".exe")) {
        Send("{Lbutton down}")
        Sleep(5)
        Send("{Lbutton up}")
        Sleep(5)
        Send("{" SilentShotKey " down}")
        Sleep(25)
        Send("{1 down}")
        Sleep(5)
        Send("{1 up}")
        Sleep(5)
        Send("{" SilentShotKey " up}")
        Sleep(5)
        Send("{RButton up}")
    }
}

; RechamberCancelScript(*) {
;     If (WinActive("ahk_exe " Application ".exe")) {
;         Send("{1}")
;     }
; }

RapidFireScript(*) {
    If (WinActive("ahk_exe " Application ".exe")) {
        While GetKeyState("LButton", "P") {
            MouseClick("Left")
            Sleep(50)
        }
    }
}

SlideCancelScript(*) {
    If (WinActive("ahk_exe " Application ".exe")) {
        ; ======================================
        ; MW2
        ; ======================================
        ; Send("{" SlideCancelSlideKeybind "}")
        ; Sleep(50)
        ; Send("{" SlideCancelCancelKeybind "}")
        ; Sleep(5)
        ; Send("{" SlideCancelCancelKeybind "}")

        ; =========================================
        ; MW2019
        ; =========================================
        Send("{" SlideCancelSlideKeybind " down}")
        Sleep(80)
        Send("{" SlideCancelSlideKeybind " up}")
        Sleep(80)
        Send("{" SlideCancelSlideKeybind " down}")
        Sleep(80)
        Send("{" SlideCancelSlideKeybind " up}")
        Sleep(35)
        Send("{" SlideCancelCancelKeybind " down}")
        Sleep(70)
        Send("{" SlideCancelCancelKeybind " up}")
        Sleep(70)
        Send("{" SlideCancelSprintKeybind "}")
    }
}

toggleSilentShot() {
    global silentShotEnabled
    global rapidFireEnabled

    If (WinActive("ahk_exe " Application ".exe")) {
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

; toggleRechamberCancel() {
;     global rechamberCancelEnabled

;     If (WinActive("ahk_exe " Application ".exe")) {
;         If (rechamberCancelEnabled = 0) {
;             Hotkey(RechamberCancelKey, RechamberCancelScript, "Off")
;             Hotkey(RechamberCancelKey, RechamberCancelScript, "On")

;             rechamberCancelEnabled := 1

;             SoundBeep 1000
;             SoundBeep 500
;             SoundBeep 1000
;             SoundBeep 500
;             SoundBeep 1000
;         }
;         else {
;             Hotkey(RechamberCancelKey, RechamberCancelScript, "Off")

;             rechamberCancelEnabled := 0

;             SoundBeep 500
;             SoundBeep 1000
;             SoundBeep 500
;             SoundBeep 1000
;             SoundBeep 500
;         }
;     }
; }

toggleRapidFire() {
    global rapidFireEnabled
    global silentShotEnabled

    If (WinActive("ahk_exe " Application ".exe")) {
        If (rapidFireEnabled = 0) {
            Hotkey("LButton", SilentShotScript, "Off")
            Hotkey("LButton", RapidFireScript, "Off")

            Hotkey("LButton", RapidFireScript, "On")

            rapidFireEnabled := 1
            silentShotEnabled := 0

            SoundBeep 1000
            SoundBeep 500
            SoundBeep 1000
            SoundBeep 500
        }
        else {
            Hotkey("LButton", SilentShotScript, "Off")
            Hotkey("LButton", RapidFireScript, "Off")

            silentShotEnabled := 0

            SoundBeep 500
            SoundBeep 1000
            SoundBeep 500
            SoundBeep 1000
        }
    }
}

toggleSlideCancel() {
    global slideCancelEnabled

    If (WinActive("ahk_exe " Application ".exe")) {
        if (slideCancelEnabled = 0) {
            Hotkey(SlideCancelActivatorKeybind, SlideCancelScript, "Off")
            Hotkey(SlideCancelActivatorKeybind, SlideCancelScript, "On")

            slideCancelEnabled := 1

            SoundBeep 1000
            SoundBeep 500
            SoundBeep 1000
            SoundBeep 500
            SoundBeep 1000
        }
        else {
            Hotkey(SlideCancelActivatorKeybind, SlideCancelScript, "Off")

            slideCancelEnabled := 0

            SoundBeep 500
            SoundBeep 1000
            SoundBeep 500
            SoundBeep 1000
            SoundBeep 500
        }
    }
}

disableAll() {
    global silentShotEnabled
    global rapidFireEnabled
    global slideCancelEnabled

    If (WinActive("ahk_exe " Application ".exe")) {
        SoundBeep 1000
        SoundBeep 500
        SoundBeep 1000
        SoundBeep 500
        SoundBeep 1000
        SoundBeep 500

        silentShotEnabled := 0
        rapidFireEnabled := 0
        slideCancelEnabled := 0

        Hotkey("LButton", SilentShotScript, "Off")
        Hotkey("LButton", RapidFireScript, "Off")
        Hotkey("C", SlideCancelScript, "Off")
    }
}