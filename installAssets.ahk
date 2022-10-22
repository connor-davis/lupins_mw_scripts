DirCreate(A_MyDocuments "/LMWS/assets/")
SetWorkingDir(A_MyDocuments "/LMWS/assets/")

Sleep(100)

If (!FileExist(A_WorkingDir "/All_Scripts_Disabled.wav")) {
    FileInstall("assets/All_Scripts_Disabled.wav", A_WorkingDir "/All_Scripts_Disabled.wav")
}

If (!FileExist(A_WorkingDir "/Silent_Shot_Enabled.wav")) {
    FileInstall("assets/Silent_Shot_Enabled.wav", A_WorkingDir "/Silent_Shot_Enabled.wav")
}

If (!FileExist(A_WorkingDir "/Silent_Shot_Disabled.wav")) {
    FileInstall("assets/Silent_Shot_Disabled.wav", A_WorkingDir "/Silent_Shot_Disabled.wav")
}

If (!FileExist(A_WorkingDir "/Rapid_Fire_Enabled.wav")) {
    FileInstall("assets/Rapid_Fire_Enabled.wav", A_WorkingDir "/Rapid_Fire_Enabled.wav")
}

If (!FileExist(A_WorkingDir "/Rapid_Fire_Disabled.wav")) {
    FileInstall("assets/Rapid_Fire_Disabled.wav", A_WorkingDir "/Rapid_Fire_Disabled.wav")
}

If (!FileExist(A_WorkingDir "/Slide_Cancel_Enabled.wav")) {
    FileInstall("assets/Slide_Cancel_Enabled.wav", A_WorkingDir "/Slide_Cancel_Enabled.wav")
}

If (!FileExist(A_WorkingDir "/Slide_Cancel_Disabled.wav")) {
    FileInstall("assets/Slide_Cancel_Disabled.wav", A_WorkingDir "/Slide_Cancel_Disabled.wav")
}