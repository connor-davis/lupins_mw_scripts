#SingleInstance Force
#MaxThreadsPerHotkey 8
#Requires AutoHotkey v2.0-a

guiWidth := 500
guiHeight := 405
screenCenterX := (A_ScreenWidth / 2) - (guiWidth / 2)
screenCenterY := (A_ScreenHeight / 2) - (guiHeight / 2)

silentShotEnabled := 0
rapidFireEnabled := 0
slideCancelEnabled := 0

g_LMWS := Gui(, "LoneWolf MW Scripts v1")
g_LMWS.OnEvent("Close", GuiClose)
g_LMWS.BackColor := "191919"

g_LMWS_Title := g_LMWS.Add("Text", "W500 H30 Center", "LoneWolf MW Scripts")
g_LMWS_Title.SetFont("c16a34a Bold S22")

g_LMWS_Message := g_LMWS.Add("Text", "W480 H70", "Welcome to LoneWolf MW Scripts. Please note the use of these scripts does not form part of `"hacking`" and never will be. All these scripts do is give you the lazy way of staying on a similar level to sweats. Use it at your own risk. I will not be liable for anything that happens.")
g_LMWS_Message.SetFont("cd6d3d1 S10")

g_LMWS_HotkeyList := g_LMWS.Add("Text", "W480 H20", "Hotkeys:")
g_LMWS_HotkeyList.SetFont("c16a34a Bold S12")

g_LMWS_SilentShotHotkey := g_LMWS.Add("Text", "W480 H20", "Silent Shot: `t`t`tF2")
g_LMWS_SilentShotHotkey.SetFont("cffffff S11")

g_LMWS_RapidFireHotkey := g_LMWS.Add("Text", "W480 H20", "Rapid Fire: `t`t`tF3")
g_LMWS_RapidFireHotkey.SetFont("cffffff S11")

g_LMWS_DisableAllHotkey := g_LMWS.Add("Text", "W480 H20", "Slide Cancel: `t`t`tF4 - Activates on press of 'C'")
g_LMWS_DisableAllHotkey.SetFont("cffffff S11")

g_LMWS_DisableAllHotkey := g_LMWS.Add("Text", "W480 H30", "Disable All: `t`t`tF5")
g_LMWS_DisableAllHotkey.SetFont("cffffff S11")

g_LMWS_HotkeyList := g_LMWS.Add("Text", "W480 H20", "Extra:")
g_LMWS_HotkeyList.SetFont("c16a34a Bold S12")

g_LMWS_DisableAllHotkey := g_LMWS.Add("Text", "W480 H20", "Silent Shot Lethal Key:")
g_LMWS_DisableAllHotkey.SetFont("cffffff S11")
g_LMWS_SilentShotLethalHotkey_Input := g_LMWS.Add("Hotkey", "vSilentShotKey W480", SilentShotKey := "F")
g_LMWS_SilentShotLethalHotkey_Input.OnEvent("Change", ChangeSilentShotLethalKey.Bind("Change"))

g_LMWS.Show("W" guiWidth " H" guiHeight " y" screenCenterY " x" screenCenterX)

SoundBeep

ChangeSilentShotLethalKey(A_GuiEvent, GuiCtrlObj, Info, *) {
    global SilentShotKey
    o := g_LMWS.Submit("0")
    SilentShotKey := o.SilentShotKey
}

F2:: enableSilentShot
F3:: enableRapidFire
F4:: enableSlideCancel
F5:: disableAll

SilentShotScript(*) {
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

RapidFireScript(*) {
    While GetKeyState("LButton", "P") {
        MouseClick("Left")
        Sleep(50)
    }
}

SlideCancel(*) {
    Sleep(150)
    Send("{XButton1}")
}

enableSilentShot() {
    global silentShotEnabled

    SoundBeep(1000)
    SoundBeep(500)

    if (silentShotEnabled = 1) {
        Hotkey("LButton", SilentShotScript, "Off")
        Hotkey("LButton", RapidFireScript, "Off")

        silentShotEnabled := 0
    }
    else {
        Hotkey("LButton", SilentShotScript, "Off")
        Hotkey("LButton", RapidFireScript, "Off")

        Hotkey("LButton", SilentShotScript, "On")

        silentShotEnabled := 1
    }
}

enableRapidFire() {
    global rapidFireEnabled

    SoundBeep(1000)
    SoundBeep(500)
    SoundBeep(1000)

    if (rapidFireEnabled = 1) {
        Hotkey("LButton", SilentShotScript, "Off")
        Hotkey("LButton", RapidFireScript, "Off")

        rapidFireEnabled := 0
    } 
    else {
        Hotkey("LButton", SilentShotScript, "Off")
        Hotkey("LButton", RapidFireScript, "Off")

        Hotkey("LButton", RapidFireScript, "On")

        rapidFireEnabled := 1
    }
}

enableSlideCancel() {
    global slideCancelEnabled

    SoundBeep(1000)
    SoundBeep(500)
    SoundBeep(1000)
    SoundBeep(500)

    if (slideCancelEnabled = 1) {
        Hotkey("C", SlideCancel, "Off")

        slideCancelEnabled := 0
    }
    else {
        Hotkey("C", SlideCancel, "Off")
        Hotkey("C", SlideCancel, "On")

        slideCancelEnabled := 1
    }
}

disableAll() {
    global silentShotEnabled
    global rapidFireEnabled
    global slideCancelEnabled

    SoundBeep(1000)
    SoundBeep(500)
    SoundBeep(1000)
    SoundBeep(500)
    SoundBeep(1000)

    Hotkey("LButton", SilentShotScript, "Off")
    Hotkey("LButton", RapidFireScript, "Off")
    Hotkey("C", SlideCancel, "Off")

    silentShotEnabled := 0
    rapidFireEnabled := 0
    slideCancelEnabled := 0
}

GuiClose(*) {
    ExitApp()
}