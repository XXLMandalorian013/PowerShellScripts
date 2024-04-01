    #ReadMe
<#
    
.SYNOPSIS

Adds a file name extension to a supplied name.


.DESCRIPTION
        
Adds a file name extension to a supplied name.  
    
    
.Notes

Notes here.
    

.PARAMETER Name
        
Specifies the file name.

    
.PARAMETER Extension
        
Specifies the extension. "Txt" is the default.


.INPUTS
        
None. You cannot pipe objects to Add-Extension.


.OUTPUTS
        
System.String. Add-Extension returns a string with the extension or file name.


.EXAMPLE
        
PS> extension "File" "doc"
File.doc


.LINK
        
[WinGet Install Online Version](https://learn.microsoft.com/en-us/windows/package-manager/winget/install) 

#>

#Script


$OutFilePath = "C:\TEMP"

$TestPath = "$OutFilePath"

$URL = "https://www.autodesk.com/adsk-connect-64"

$ProgramName = "DesktopConnector-x64.exe"


#TEMP Folder Check/Creation

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
        
Write-Host "Downloading $ProgramName..."
    
Invoke-WebRequest $URL  -OutFile C:\TEMP\"$ProgramName"


#Extract installer

Set-Location -Path "C:\TEMP"

Write-Host "Extracting $ProgramName..."

Start-Sleep -Seconds 2

New-Item -Path "$OutFilePath" -Name "DesktopConnector.bat" -ItemType "file" -Value 'CD C:\TEMP
DesktopConnector-x64.exe -suppresslaunch -d "C:\TEMP"'

Start-Process -Verb RunAs "C:\TEMP\DesktopConnector.bat"

Start-Sleep -Seconds 3


#Run installer

Set-Location -Path "C:\TEMP\Autodesk_Desktop_Connector_15_8_0_1827_Win_64bit"

Write-Host "Installing $ProgramName..."

Start-Sleep -Seconds 2

Start-Process -FilePath "C:\TEMP\Autodesk_Desktop_Connector_15_8_0_1827_Win_64bit\Setup.exe" -wait -ArgumentList "-i install --silent"

Write-Host "Ending Script..."

Start-Sleep -Seconds 3



