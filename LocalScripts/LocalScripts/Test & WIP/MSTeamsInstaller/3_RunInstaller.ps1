#Runs installer

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-7.2

    Write-Host "Running MS Teams Installer 64 Bit for all users..."

    Start-Sleep -Seconds 3

    Start-Process -FilePath "C:\TEMP\TeamsSetup_c_w_.exe" 

    Write-Host "Installer is starting..."

    Start-Sleep -Seconds 3