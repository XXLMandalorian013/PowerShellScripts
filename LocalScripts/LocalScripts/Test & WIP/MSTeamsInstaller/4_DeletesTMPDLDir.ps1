#Removes a file from a folder

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-path?view=powershell-7.2

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.2   
       
    $UserName = $env:UserName

    $TestPath2 = Get-Childitem C:\Users\$UserName\AppData\Local\Microsoft\Teams\Update.exe -File -Force -Recurse


    if(Test-Path -Path "$TestPath2" -ErrorAction Ignore)
    {

        Write-Host "Teams has been installed, please finish its setup....This script will now remove the downloaded file and its Dir"

        Start-Sleep -Seconds 4

        Remove-Item C:\TEMP\TeamsSetup_c_w_.exe

        Remove-Item C:\TEMP

    }