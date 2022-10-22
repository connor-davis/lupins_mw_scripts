#SingleInstance Force
#MaxThreads 4
#Requires AutoHotkey v2.0-a
#Include Jxon.ahk

URL := "https://api.github.com/repos/connor-davis/lupins_mw_scripts/releases/latest"
DownloadsPath := A_ScriptDir
LatestVersionFileName := ""
LatestVersion := ""

CheckForUpdate(AppVersion, WebRequest) {
    global LatestVersionFileName
    global LatestVersion

    WebRequest.Open("GET", URL)
    WebRequest.Send()

    text := WebRequest.ResponseText

    obj := jxon_load(&text)

    latestReleaseVersion := StrReplace(obj["tag_name"], ".", "")
    latestReleaseVersion := StrReplace(latestReleaseVersion, "v", "")
    installedVersion := StrReplace(AppVersion, ".", "")

    If (latestReleaseVersion > installedVersion) {
        LatestVersionFileName := obj["assets"][1]["name"]
        LatestVersion := StrReplace(obj["tag_name"], "v", "")
    }

    return latestReleaseVersion > installedVersion
}

DownloadUpdate() {
    global LatestVersion
    global LatestVersionFileName

    Download("https://github.com/connor-davis/lupins_mw_scripts/releases/download/v" LatestVersion "/" LatestVersionFileName, DownloadsPath "\" LatestVersionFileName)
}

RunUpdate() {
    global LatestVersion

    IniWrite(LatestVersion, A_MyDocuments "\LMWS\config.ini", "Information", "AppVersion")
    Run(DownloadsPath "\" LatestVersionFileName)
}

DeleteOldVersion() {
    LastAppVersion := IniRead(A_MyDocuments "\LMWS\config.ini", "Information", "AppVersion", "1.0.7")

    try
        FileDelete(DownloadsPath "\LoneWolfMwScriptsV" LastAppVersion ".exe")
    catch
        return
}