#SingleInstance Force
#DllLoad gdiplus
#Requires AutoHotkey v2.0-a

if (!DirExist(A_MyDocuments "\LMWS")) {
    DirCreate(A_MyDocuments "\LMWS")
}

silentShotEnabled := 0
rapidFireEnabled := 0
slideCancelEnabled := 0
silentShotCheckboxHwnd := 0
rapidFireCheckboxHwnd := 0
slideCancelCheckboxHwnd := 0

SilentShotKey := IniRead(A_MyDocuments "\LMWS\config.ini", "Silent Shot", "key", "F")
SlideCancelActivatorKeybind := IniRead(A_MyDocuments "\LMWS\config.ini", "Slide Cancel", "activatorKey", "C")
SlideCancelSlideKeybind := IniRead(A_MyDocuments "\LMWS\config.ini", "Slide Cancel", "slideKey", "C")
SlideCancelJumpKeybind := IniRead(A_MyDocuments "\LMWS\config.ini", "Slide Cancel", "jumpKey", "Space")
SlideCancelSprintKeybind := "LShift"

guiWidth := 500
guiHeight := 635
screenCenterX := (A_ScreenWidth / 2) - (guiWidth / 2)
screenCenterY := (A_ScreenHeight / 2) - (guiHeight / 2)

g_LMWS := Gui(, "LoneWolf MW Scripts v1.0.3")
g_LMWS.OnEvent("Close", GuiClose)

g_LMWS_Title := g_LMWS.Add("Text", "W500 H24 X10 Y10", "LoneWolf MW Scripts")
g_LMWS_Title.SetFont("c22a55e Bold S16")

g_LMWS_Message := g_LMWS.Add("Text", "W480 H80", "Welcome to LoneWolf MW Scripts. These scripts make your life easier when it comes to key-combinations in modern warfare. These do not give you “hacks”. Use the scripts at your own risk, I will not be liable for anything that happens while using them.")
g_LMWS_Message.SetFont("S12")

g_LMWS_HotkeyList := g_LMWS.Add("Text", "W480 H24", "Hotkeys:")
g_LMWS_HotkeyList.SetFont("c22a55e Bold S14")

; Silent Shot
g_LMWS_SilentShotHotkey := g_LMWS.Add("Text", "W390 H20 X10", "Silent Shot: `t`t`tF2")
g_LMWS_SilentShotHotkey.SetFont("S12")

g_LMWS_SilentShotCheckbox := g_LMWS.Add("Checkbox", "W80 H20 X+10 vSilentShotHotkeyCheckbox", "Enabled")
g_LMWS_SilentShotCheckbox.SetFont("S12")
g_LMWS_SilentShotCheckbox.OnEvent("Click", SilentShotCheckboxChanged)

; Rapid Fire
g_LMWS_RapidFireHotkey := g_LMWS.Add("Text", "W390 H20 X10", "Rapid Fire: `t`t`tF3")
g_LMWS_RapidFireHotkey.SetFont("S12")

g_LMWS_RapidFireCheckbox := g_LMWS.AddCheckbox("W80 H20 X+10 vRapidFireHotkeyLabel", "Enabled")
g_LMWS_RapidFireCheckbox.SetFont("S12")
g_LMWS_RapidFireCheckbox.OnEvent("Click", RapidFireCheckboxChanged)

; Slide Cancel
g_LMWS_SlideCancelHotkey := g_LMWS.Add("Text", "W390 H20 X10", "Slide Cancel: `t`t`tF4")
g_LMWS_SlideCancelHotkey.SetFont("S12")

g_LMWS_SlideCancelCheckbox := g_LMWS.AddCheckbox("W80 H20 X+10 vSlideCancelHotkeyCheckbox", "Enabled")
g_LMWS_SlideCancelCheckbox.SetFont("S12")
g_LMWS_SlideCancelCheckbox.OnEvent("Click", SlideCancelCheckboxChanged)
slideCancelCheckboxHwnd := g_LMWS_SlideCancelCheckbox.Hwnd

; Disable All
g_LMWS_DisableAllHotkey := g_LMWS.Add("Text", "W480 H30 X10", "Disable All: `t`t`tF5")
g_LMWS_DisableAllHotkey.SetFont("S12")

g_LMWS_HotkeyList := g_LMWS.Add("Text", "W480 H25", "Configuration:")
g_LMWS_HotkeyList.SetFont("c22a55e Bold S14")

; Silent Shot Lethal Key Input
g_LMWS_SilentShotLethalKeyLabel := g_LMWS.Add("Text", "W480 H20", "Silent Shot Lethal Key:")
g_LMWS_SilentShotLethalKeyLabel.SetFont("S12")
g_LMWS_SilentShotLethalHotkey_Input := g_LMWS.AddEdit("vSilentShotKey W480", SilentShotKey)
g_LMWS_SilentShotLethalHotkey_Input.OnEvent("Change", ChangeSilentShotLethalKey.Bind("Change"))

; Slide Cancel Usage
g_LMWS_SlideCancelLabel := g_LMWS.Add("Text", "W480 H20", "Slide Cancel:")
g_LMWS_SlideCancelLabel.SetFont("S12")

g_LMWS_SlideCancelActivatorKeyLabel := g_LMWS.Add("Text", "W480 H20", "Activator Key")
g_LMWS_SlideCancelActivatorKeyLabel.SetFont("S11")
g_LMWS_SlideCancelActivatorKey_Input := g_LMWS.AddEdit("vSlideCancelActivatorKey W480", SlideCancelActivatorKeybind)
g_LMWS_SlideCancelActivatorKey_Input.OnEvent("Change", ChangeSlideCancelActivatorKey.Bind("Change"))

g_LMWS_SlideCancelSlideKeyLabel := g_LMWS.Add("Text", "W480 H20", "Slide Key")
g_LMWS_SlideCancelSlideKeyLabel.SetFont("S11")
g_LMWS_SlideCancelSlideKey_Input := g_LMWS.AddEdit("vSlideCancelSlideKey W480", SlideCancelSlideKeybind)
g_LMWS_SlideCancelSlideKey_Input.OnEvent("Change", ChangeSlideCancelSlideKey.Bind("Change"))

g_LMWS_SlideCancelJumpKeyLabel := g_LMWS.Add("Text", "W480 H20", "Jump Key")
g_LMWS_SlideCancelJumpKeyLabel.SetFont("S11")
g_LMWS_SlideCancelJumpKey_Input := g_LMWS.AddEdit("vSlideCancelJumpKey W480", SlideCancelJumpKeybind)
g_LMWS_SlideCancelJumpKey_Input.OnEvent("Change", ChangeSlideCancelJumpKey.Bind("Change"))

g_LMWS_ApplyButton := g_LMWS.AddButton("", "Apply Changes")
g_LMWS_ApplyButton.BackColor := "22e55a"
g_LMWS_ApplyButton.OnEvent("Click", ApplyChanges)

g_LMWS_StatusBar := g_LMWS.AddStatusBar("", "")

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

Display() {
    g_LMWS.Show("W" guiWidth " H" guiHeight " y" screenCenterY " x" screenCenterX)
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

F2:: {
    If (WinActive("ahk_exe ModernWarfare.exe")) {
        toggleSilentShot()

        GuiCtrlFromHwnd(g_LMWS_SilentShotCheckbox.Hwnd).Value := !GuiCtrlFromHwnd(g_LMWS_SilentShotCheckbox.Hwnd).Value
    }
}

F3:: {
    If (WinActive("ahk_exe ModernWarfare.exe")) {
        toggleRapidFire()

        GuiCtrlFromHwnd(g_LMWS_RapidFireCheckbox.Hwnd).Value := !GuiCtrlFromHwnd(g_LMWS_RapidFireCheckbox.Hwnd).Value
    }
}

F4:: {
    If (WinActive("ahk_exe ModernWarfare.exe")) {
        toggleSlideCancel()

        GuiCtrlFromHwnd(g_LMWS_SlideCancelCheckbox.Hwnd).Value := !GuiCtrlFromHwnd(g_LMWS_SlideCancelCheckbox.Hwnd).Value
    }
}

F5:: {
    If (WinActive("ahk_exe ModernWarfare.exe")) {
        disableAll()

        GuiCtrlFromHwnd(g_LMWS_SilentShotCheckbox.Hwnd).Value := 0
        GuiCtrlFromHwnd(g_LMWS_RapidFireCheckbox.Hwnd).Value := 0
        GuiCtrlFromHwnd(g_LMWS_SlideCancelCheckbox.Hwnd).Value := 0
    }
}

SilentShotScript(*) {
    If (WinActive("ahk_exe ModernWarfare.exe")) {
        Send "{Lbutton down}"
        Sleep(5)
        Send "{Lbutton up}"
        Sleep(5)
        Send "{" SilentShotKey "}"
        Sleep(25)
        Send "{1 down}"
        Sleep(5)
        Send "{1 up}"
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

GuiClose(*) {
    ExitApp()
}

Display()