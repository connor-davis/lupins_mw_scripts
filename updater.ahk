#SingleInstance Force
#MaxThreads 4
#Requires AutoHotkey v2.0-a

URL := "https://github.com/connor-davis/lupins_mw_scripts/releases/download/v1.0.8/LoneWolfMwScriptsV1.0.8.exe"
DownloadsPath := A_ScriptDir

CheckForUpdate(AppVersion, WebRequest) {
    WebRequest.Open("GET", URL)
    WebRequest.Send()

    return InStr(WebRequest.ResponseText, "MZ")
}

DownloadUpdate() {
    Download(URL, DownloadsPath "\LoneWolfMwScriptsV1.0.8.exe")
}

RunUpdate() {
    Run(DownloadsPath "\LoneWolfMwScriptsV1.0.8.exe")
}

DeleteOldVersion() {
    try
        FileDelete(DownloadsPath "\LoneWolfMwScriptsV1.0.6.exe")
    catch
        return
}