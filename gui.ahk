#SingleInstance Force
#MaxThreadsPerHotkey 8
#Requires AutoHotkey v2.0-a

guiWidth := 500
guiHeight := 600
screenCenterX := (A_ScreenWidth / 2) - (guiWidth / 2)
screenCenterY := (A_ScreenHeight / 2) - (guiHeight / 2)

g_LMWS := Gui(, "LoneWolf MW Scripts v1.0.2")
g_LMWS.OnEvent("Close", GuiClose)
g_LMWS.BackColor := "191919"

g_LMWS_Title := g_LMWS.Add("Text", "W500 H15 X10 Y10", "LoneWolf MW Scripts")
g_LMWS_Title.SetFont("c16a34a Bold S10")

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
; g_LMWS_SilentShotLethalHotkey_Input.OnEvent("Change", ChangeSilentShotLethalKey.Bind("Change"))

g_LMWS.Show("W" guiWidth " H" guiHeight " y" screenCenterY " x" screenCenterX)

GuiClose(*) {
    ExitApp()
}