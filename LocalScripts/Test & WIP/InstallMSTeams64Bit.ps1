#Created a folder temp folder for downloading.
    
    #https://docs.microsoft.com/en-us/powershell/scripting/samples/working-with-files-and-folders?view=powershell-7.2

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-path?view=powershell-7.2
    
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


#Downloads software from the web. Make sure to add the downloads .exe full name in the -outfile file path or you will get access denied.
    
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.2
      
    Write-Host "Downloding MS Teams for Work/School 64 Bit for all users"

    Invoke-WebRequest "https://go.microsoft.com/fwlink/p/?LinkID=2187327&clcid=0x409&culture=en-us&country=US" -OutFile "C:\TEMP\TeamsSetup_c_w_.exe"

#Runs installer

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-7.2

        Write-Host "Running MS Teams Installer 64 Bit for all users..."

        Start-Sleep -Seconds 3

        Start-Process -FilePath "C:\TEMP\TeamsSetup_c_w_.exe" 

        Write-Host "Installer is starting..."

        Start-Sleep -Seconds 3

       
       
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