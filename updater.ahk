#SingleInstance Force
#MaxThreads 4
#Requires AutoHotkey v2.0-a

NextVersion := "1.0.5"
URL := "https://github.com/connor-davis/lupins_mw_scripts/releases/download/v" NextVersion "/LoneWolfMwScriptsV" NextVersion ".exe"
DownloadsPath := A_ScriptDir

CheckForUpdate(AppVersion, WebRequest) {
    If (!(AppVersion = NextVersion)) {
        WebRequest.Open("GET", URL)
        WebRequest.Send()

        return WebRequest.ResponseText = "MZ"
    } else {
        return 0
    }
}

DownloadUpdate() {
    Download(URL, DownloadsPath "\LoneWolfMwScriptsV" NextVersion ".exe")
}

RunUpdate() {
    Run(DownloadsPath "\LoneWolfMwScriptsV" NextVersion ".exe")
}

DeleteOldVersion() {
    try
        FileDelete(DownloadsPath "\LoneWolfMwScriptsV1.0.3.exe")
    catch
        return
}