#Anydesk Programfiles 86 uninstall check.
$DirName = "C:\Program Files (x86)\AnyDesk"
$FileName = "anydesk.exe"
try {
    if (Test-Path -Path "$DirName") {
        Write-Verbose -Message "$DirName exsist...Moving to next step." -Verbose
        try {
            Write-Verbose -Message "Starting uninstall" -Verbose
            Set-Location -path "$DirName"
            Start-Process -FilePath "$FileName" -ArgumentList "--remove"
            Start-Sleep -Seconds 30
            Write-Verbose -Message "uninstall complete?" -Verbose
        }
        catch {
            Get-Error -Newest 1
        }
    }else {
        Write-Verbose -Message "$DirName not found..." -Verbose
    }
}catch {
    Get-Error -Newest 1
}
