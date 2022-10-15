#SingleInstance Force
#MaxThreadsPerHotkey 8
#Requires AutoHotkey v2.0-a

imgLogo := LoadPicture("resources/assets/logo.png")

guiWidth := 500
guiHeight := 365
screenCenterX := (A_ScreenWidth / 2) - (guiWidth / 2)
screenCenterY := (A_ScreenHeight / 2) - (guiHeight / 2)

silentShotEnabled := 0
rapidFireEnabled := 0

g_LMWS := Gui(, "Lupins MW Scripts v1")
g_LMWS.OnEvent("Close", GuiClose)
g_LMWS.BackColor := "191919"

g_LMWS_Title := g_LMWS.Add("Text", "W500 H30 Center", "Lupins MW Scripts")
g_LMWS_Title.SetFont("c16a34a Bold S22")

g_LMWS_Message := g_LMWS.Add("Text", "W480 H60", "Welcome to Lupins MW Scripts. Please note the use of these scripts does not form part of `"hacking`" and never will be. All these scripts do is give you the lazy way of staying on a similar level to sweats.")
g_LMWS_Message.SetFont("cd6d3d1 S10")

g_LMWS_HotkeyList := g_LMWS.Add("Text", "W480 H20", "Hotkeys:")
g_LMWS_HotkeyList.SetFont("c16a34a Bold S12")

g_LMWS_SilentShotHotkey := g_LMWS.Add("Text", "W480 H20", "Silent Shot: `t`t`tF2")
g_LMWS_SilentShotHotkey.SetFont("cffffff S11")

g_LMWS_RapidFireHotkey := g_LMWS.Add("Text", "W480 H20", "Rapid Fire: `t`t`tF3")
g_LMWS_RapidFireHotkey.SetFont("cffffff S11")

g_LMWS_DisableAllHotkey := g_LMWS.Add("Text", "W480 H30", "Disable All: `t`t`tF4")
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
F4:: disableAll

SilentShotScript(*) {
    Send "{Lbutton down}"
    Sleep(10)
    Send "{Lbutton up}"
    Sleep(10)
    Send "{" SilentShotKey "}"
    Sleep(50)
    Send "{1 down}"
    Sleep(10)
    Send "{1 up}"
}

RapidFireScript(*) {
    Loop {
        MouseClick("Left")
        Sleep(50)
    } Until GetKeyState("LButton", "P") = 0
}

enableSilentShot() {
    SoundBeep
    SoundBeep

    Hotkey("LButton", SilentShotScript, "Off")
    Hotkey("LButton", RapidFireScript, "Off")

    Hotkey("LButton", SilentShotScript, "On")
}

enableRapidFire() {
    SoundBeep
    SoundBeep
    SoundBeep

    Hotkey("LButton", SilentShotScript, "Off")
    Hotkey("LButton", RapidFireScript, "Off")

    Hotkey("LButton", RapidFireScript, "On")
}

disableAll() {
    SoundBeep
    SoundBeep
    SoundBeep
    SoundBeep

    Hotkey("LButton", SilentShotScript, "Off")
    Hotkey("LButton", RapidFireScript, "Off")
}

GuiClose(*) {
    ExitApp()
}