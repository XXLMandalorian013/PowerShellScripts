#Vars
#Source program path.
$TargetFile = "C:\Program Files (x86)\Zultys\ZAC\zac.exe"
#Copies the shortcut to all users desktop.
$ShortcutFile = "$env:Public\Desktop\zac.lnk"
#Script
if (Test-Path $TargetFile) {
    Write-verbose -Message "Creating shortcut for $TargetFile on all users desktop..." -Verbose
    #Creates the COM object
    $WScriptShell = New-Object -ComObject WScript.Shell
    #Creates the shortcut .lnk
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
    #Sets the path to copy the .lnk to.
    $Shortcut.TargetPath = $TargetFile
    #Saves the shortcut /copies the .lnk.
    $Shortcut.Save()
}else {
    Throw "Could not find $TargetFile...ending script..."
}

