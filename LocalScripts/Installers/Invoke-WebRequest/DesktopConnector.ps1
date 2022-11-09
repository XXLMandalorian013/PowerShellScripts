#Created a folder temp folder for downloading.
    
    #https://docs.microsoft.com/en-us/powershell/scripting/samples/working-with-files-and-folders?view=powershell-7.2

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-path?view=powershell-7.2


$OutFilePath = "C:\TEMP"

$TestPath = "$OutFilePath"

$URL = "https://www.autodesk.com/adsk-connect-64"

$ProgramName = "DesktopConnector-x64.exe"

        if(Test-Path -Path "$TestPath")
		{

		Write-Host "$OutFilePath Exists..."

        Start-Sleep -Seconds 3

		}

		else

		{

            Write-Host "Creating $OutFilePath..."

            Start-Sleep -Seconds 2

            New-Item -Path "$OutFilePath" -ItemType Directory -ErrorAction Ignore

		}

#Downloads software from the web. Make sure to add the downloads .exe full name in the -outfile file path or you will get access denied.
        
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.2
          
        Write-Host "Downloading $ProgramName..."
    
        Invoke-WebRequest $URL  -OutFile C:\TEMP\"$ProgramName"

#Extract installer

        #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-7.2

            Set-Location -Path "C:\TEMP"

            Write-Host "Extracting $ProgramName..."

            Start-Sleep -Seconds 2

            New-Item -Path "$OutFilePath" -Name "DesktopConnector.bat" -ItemType "file" -Value 'CD C:\TEMP
            DesktopConnector-x64.exe -suppresslaunch -d "C:\TEMP"'

            Start-Process -Verb RunAs "C:\TEMP\DesktopConnector.bat"

            Start-Sleep -Seconds 3

#Run installer

        #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-7.2

        Set-Location -Path "C:\TEMP\Autodesk_Desktop_Connector_15_8_0_1827_Win_64bit"

        Write-Host "Installing $ProgramName..."

        Start-Sleep -Seconds 2

        Start-Process -FilePath "C:\TEMP\Autodesk_Desktop_Connector_15_8_0_1827_Win_64bit\Setup.exe" -wait -ArgumentList "-i install --silent"

        Write-Host "Ending Script..."

        Start-Sleep -Seconds 3



            

