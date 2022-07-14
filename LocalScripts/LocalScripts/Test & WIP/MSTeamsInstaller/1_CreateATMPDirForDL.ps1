#Created a folder temp folder for downloading.
    
    #https://docs.microsoft.com/en-us/powershell/scripting/samples/working-with-files-and-folders?view=powershell-7.2

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-path?view=powershell-7.2

    #https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2
    
    $TestPath = "C:\TEMP\"

    if(Test-Path -Path "$TestPath")
    {

        Write-Host "C:\TEMP\ Directory Exists for download..."

        Start-Sleep -Seconds 3

    }

    else

    {

        Write-Host "Creating C:\TEMP\ Directory..."

        Start-Sleep -Seconds 3

        New-Item -Path 'C:\TEMP\' -ItemType Directory -ErrorAction Ignore

    }