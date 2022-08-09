#Created a folder temp folder for downloading.
    
    #https://docs.microsoft.com/en-us/powershell/scripting/samples/working-with-files-and-folders?view=powershell-7.2

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-path?view=powershell-7.2
    
        $TestPath = "C:\TEMP\"

        if(Test-Path -Path "$TestPath")
		{

		Write-Host "Directory Exists..."

        Start-Sleep -Seconds 3

		}

		else

		{

            Write-Host "Creating Directory..."

            Start-Sleep -Seconds 2

            New-Item -Path 'C:\TEMP\' -ItemType Directory -ErrorAction Ignore

		}


#Downloads software from the web. Make sure to add the downloads .exe full name in the -outfile file path or you will get access denied.
        
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.2
          
        Write-Host "Downloading File..."
    
        Invoke-WebRequest https://github.com/PowerShell/PowerShell/releases/download/v7.2.4/PowerShell-7.2.4-win-x64.msi -OutFile C:\TEMP\PowerShell-7.2.4-win-x64.msi

#Runs installer

        #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-7.2

            Write-Host "Running Installer..."

            Start-Sleep -Seconds 2

            Start-Process -FilePath "C:\TEMP\PowerShell-7.2.4-win-x64.msi" 

            Write-Host "Ending Script..."

            Start-Sleep -Seconds 3