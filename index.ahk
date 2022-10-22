#SingleInstance Force
#MaxThreads 4
#Requires AutoHotkey v2.0-a
#Include updater.ahk
#Include hotkeys.ahk
#Include scripts.ahk

ComputerName := A_ComputerName

if (!DirExist(A_MyDocuments "\LMWS")) {
    DirCreate(A_MyDocuments "\LMWS")
}

AppVersion := IniRead(A_MyDocuments "\LMWS\config.ini", "Information", "AppVersion", "1.0.7")

WebRequest := ComObject("WinHttp.WinHttpRequest.5.1")

UpdateAvailable := CheckForUpdate(AppVersion, WebRequest)

if (UpdateAvailable) {
    MsgBox("Update found. Downloading the update now.")

    DownloadUpdate()
    RunUpdate()

    ExitApp()
}
else {
    DeleteOldVersion()

    IniWrite(AppVersion, A_MyDocuments "\LMWS\config.ini", "Information", "LastAppVersion")

    hidden := 1

    silentShotEnabled := 0
    unscopeAfterSilentShotEnabled := 0
    ; rechamberCancelEnabled := 0
    rapidFireEnabled := 0
    slideCancelEnabled := 0
    silentShotCheckboxHwnd := 0
    rapidFireCheckboxHwnd := 0
    slideCancelCheckboxHwnd := 0

    SilentShotKey := IniRead(A_MyDocuments "\LMWS\config.ini", "Silent Shot", "key", "F")
    UnscopeAfterSilentShotEnabled := IniRead(A_MyDocuments "\LMWS\config.ini", "Silent Shot", "unscopeAfterSilentShotEnabled", 0)
    ; RechamberCancelKey := IniRead(A_MyDocuments "\LMWS\config.ini", "Rechamber Cancel", "key", "2")
    SlideCancelActivatorKeybind := IniRead(A_MyDocuments "\LMWS\config.ini", "Slide Cancel", "activatorKey", "C")
    SlideCancelSlideKeybind := IniRead(A_MyDocuments "\LMWS\config.ini", "Slide Cancel", "slideKey", "C")
    SlideCancelCancelKeybind := IniRead(A_MyDocuments "\LMWS\config.ini", "Slide Cancel", "cancelKey", "XButton1")
    SlideCancelSprintKeybind := "LShift"

    guiWidth := 500
    guiHeight := 710

    g_LMWS := Gui(, "LoneWolf MW Scripts v" AppVersion)
    g_LMWS.OnEvent("Close", GuiClose)

    g_LMWS_Title := g_LMWS.Add("Text", "W460 H24 X10 Y10", "LoneWolf MW Scripts")
    g_LMWS_Title.SetFont("c22a55e Bold S16")

    g_LMWS_Message := g_LMWS.Add("Text", "W480 H140 X10", "Welcome to LoneWolf MW Scripts. These scripts make your life easier when it comes to key-combinations in modern warfare. These do not give you “hacks”. Use the scripts at your own risk, I will not be liable for anything that happens while using them. Please note you can change settings under configuration without being inside the game but to enable the different scripts you will need to be in the game.")
    g_LMWS_Message.SetFont("S12")

    g_LMWS_HotkeyList := g_LMWS.Add("Text", "W480 H24", "Hotkeys:")
    g_LMWS_HotkeyList.SetFont("c22a55e Bold S14")

    ; Silent Shot
    g_LMWS_SilentShotHotkey := g_LMWS.Add("Text", "W390 H20 X10", "Silent Shot: `t`t`tF2")
    g_LMWS_SilentShotHotkey.SetFont("S12")

    g_LMWS_SilentShotCheckbox := g_LMWS.Add("Checkbox", "W80 H20 X+10 vSilentShotHotkeyCheckbox", "Enabled")
    g_LMWS_SilentShotCheckbox.SetFont("S12")
    g_LMWS_SilentShotCheckbox.OnEvent("Click", SilentShotCheckboxChanged.Bind("Click"))

    ; Rapid Fire
    g_LMWS_RapidFireHotkey := g_LMWS.Add("Text", "W390 H20 X10", "Rapid Fire: `t`t`tF3")
    g_LMWS_RapidFireHotkey.SetFont("S12")

    g_LMWS_RapidFireCheckbox := g_LMWS.AddCheckbox("W80 H20 X+10 vRapidFireHotkeyLabel", "Enabled")
    g_LMWS_RapidFireCheckbox.SetFont("S12")
    g_LMWS_RapidFireCheckbox.OnEvent("Click", RapidFireCheckboxChanged.Bind("Click"))

    ; Slide Cancel
    g_LMWS_SlideCancelHotkey := g_LMWS.Add("Text", "W390 H20 X10", "Slide Cancel: `t`t`tF4")
    g_LMWS_SlideCancelHotkey.SetFont("S12")

    g_LMWS_SlideCancelCheckbox := g_LMWS.AddCheckbox("W80 H20 X+10 vSlideCancelHotkeyCheckbox", "Enabled")
    g_LMWS_SlideCancelCheckbox.SetFont("S12")
    g_LMWS_SlideCancelCheckbox.OnEvent("Click", SlideCancelCheckboxChanged.Bind("Click"))

    ; Rechamber Cancel
    ; g_LMWS_RechamberCancelHotkey := g_LMWS.Add("Text", "W390 H20 X10", "Rechamber Cancel: `t`tF5")
    ; g_LMWS_RechamberCancelHotkey.SetFont("S12")

    ; g_LMWS_RechamberCancelCheckbox := g_LMWS.AddCheckbox("W80 H20 X+10 vRechamberCancelHotkeyCheckbox", "Enabled")
    ; g_LMWS_RechamberCancelCheckbox.SetFont("S12")
    ; g_LMWS_RechamberCancelCheckbox.OnEvent("Click", RechamberCancelCheckboxChanged)
    ; RechamberCancelCheckboxHwnd := g_LMWS_RechamberCancelCheckbox.Hwnd

    ; Disable All
    g_LMWS_DisableAllHotkey := g_LMWS.Add("Text", "W480 H20 X10", "Disable All: `t`t`tF5")
    g_LMWS_DisableAllHotkey.SetFont("S12")

    g_LMWS_HotkeyList := g_LMWS.Add("Text", "W480 H25", "Configuration:")
    g_LMWS_HotkeyList.SetFont("c22a55e Bold S14")

    ; Silent Shot Lethal Key Input
    g_LMWS_SilentShotLethalKeyLabel := g_LMWS.Add("Text", "W480 H20", "Silent Shot Lethal Key:")
    g_LMWS_SilentShotLethalKeyLabel.SetFont("S12")
    g_LMWS_SilentShotLethalHotkey_Input := g_LMWS.AddEdit("vSilentShotKey W480", SilentShotKey)
    g_LMWS_SilentShotLethalHotkey_Input.OnEvent("Change", ChangeSilentShotLethalKey.Bind("Change"))

    g_LMWS_UnscopeAfterSilentShotEnabledLabel := g_LMWS.Add("Text", "W455 H20", "Do you want the scope to exit on silent shot?")
    g_LMWS_UnscopeAfterSilentShotEnabledLabel.SetFont("S12")
    g_LMWS_UnscopeAfterSilentShotEnabledCheckbox := g_LMWS.AddCheckbox("W80 H20 X+10 vUnscopeAfterSilentShotEnabled Checked" unscopeAfterSilentShotEnabled, "")
    g_LMWS_UnscopeAfterSilentShotEnabledCheckbox.SetFont("S12")
    g_LMWS_UnscopeAfterSilentShotEnabledCheckbox.OnEvent("Click", ChangeUnscopeAfterSilentShotEnabled.Bind("Click"))

    ; Rechamber Cancel Key Input
    ; g_LMWS_RechamberCancelKeyLabel := g_LMWS.Add("Text", "W480 H20", "Rechamber Cancel Key:")
    ; g_LMWS_RechamberCancelKeyLabel.SetFont("S12")
    ; g_LMWS_RechamberCancelHotkey_Input := g_LMWS.AddEdit("vRechamberCancelKey W480", RechamberCancelKey)
    ; g_LMWS_RechamberCancelHotkey_Input.OnEvent("Change", ChangeRechamberCancelKey.Bind("Change"))

    ; Slide Cancel Usage
    g_LMWS_SlideCancelLabel := g_LMWS.Add("Text", "W480 H20 X10 Y+10", "Slide Cancel:")
    g_LMWS_SlideCancelLabel.SetFont("S12")

    g_LMWS_SlideCancelActivatorKeyLabel := g_LMWS.Add("Text", "W480 H20", "Activator Key")
    g_LMWS_SlideCancelActivatorKeyLabel.SetFont("S11")
    g_LMWS_SlideCancelActivatorKey_Input := g_LMWS.AddEdit("vSlideCancelActivatorKey W480", SlideCancelActivatorKeybind)
    g_LMWS_SlideCancelActivatorKey_Input.OnEvent("Change", ChangeSlideCancelActivatorKey.Bind("Change"))

    g_LMWS_SlideCancelSlideKeyLabel := g_LMWS.Add("Text", "W480 H20", "Slide Key")
    g_LMWS_SlideCancelSlideKeyLabel.SetFont("S11")
    g_LMWS_SlideCancelSlideKey_Input := g_LMWS.AddEdit("vSlideCancelSlideKey W480", SlideCancelSlideKeybind)
    g_LMWS_SlideCancelSlideKey_Input.OnEvent("Change", ChangeSlideCancelSlideKey.Bind("Change"))

    g_LMWS_SlideCancelCancelKeyLabel := g_LMWS.Add("Text", "W480 H20", "Cancel Key")
    g_LMWS_SlideCancelCancelKeyLabel.SetFont("S11")
    g_LMWS_SlideCancelCancelKey_Input := g_LMWS.AddEdit("vSlideCancelCancelKey W480", SlideCancelCancelKeybind)
    g_LMWS_SlideCancelCancelKey_Input.OnEvent("Change", ChangeSlideCancelCancelKey.Bind("Change"))

    g_LMWS_ApplyButton := g_LMWS.AddButton("", "Apply Changes")
    g_LMWS_ApplyButton.BackColor := "22e55a"
    g_LMWS_ApplyButton.OnEvent("Click", ApplyChanges)

    g_LMWS_StatusBar := g_LMWS.AddStatusBar("", "")

    Display() {
        g_LMWS.Show("W" guiWidth " H" guiHeight " Center")
    }

    Hide() {
        g_LMWS.Hide()
    }

    GuiClose(*) {
        ExitApp()
    }
}