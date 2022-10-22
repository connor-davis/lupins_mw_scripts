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

    LatestVersionFileName := obj["assets"][1]["name"]

    latestReleaseVersion := StrReplace(obj["tag_name"], ".", "")
    latestReleaseVersion := StrReplace(latestReleaseVersion, "v", "")
    installedVersion := StrReplace(AppVersion, ".", "")

    If (latestReleaseVersion > installedVersion) {
        LatestVersion := StrReplace(obj["tag_name"], "v", "")
    }

    return latestReleaseVersion > installedVersion
}

DownloadUpdate() {
    global LatestVersionFileName

    Download(URL, DownloadsPath "\" LatestVersionFileName)
}

RunUpdate() {
    global LatestVersion

    IniWrite(LatestVersion, A_MyDocuments "\LMWS\config.ini", "Information", "AppVersion")
    Run(DownloadsPath "\" LatestVersionFileName)
    ExitApp()
    DeleteOldVersion()
}

DeleteOldVersion() {
    try
        FileDelete(DownloadsPath "\LoneWolfMwScriptsV" AppVersion ".exe")
    catch
        return
}