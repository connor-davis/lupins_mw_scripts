End:: {
    global hidden

    If (hidden) {
        Display()
        hidden := 0
    }
    else {
        Hide()
        hidden := 1
    }
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