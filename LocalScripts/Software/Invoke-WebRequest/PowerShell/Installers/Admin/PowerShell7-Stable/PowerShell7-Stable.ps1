#ReadMe
<#

PS 7 Stable 7.3.2 web installer
    
.SYNOPSIS

Downloads and installs PowerShell 7 Stable 7.3.2 if not already installed.


.Notes

Though the installer will say its done and installed, it will take 5 or so seconds for the PC to show the newly installed program via the start menu recently added.
 

.PARAMETER Name
        
Specifies the file name.

    
.PARAMETER Extension
        
Specifies the extension. "Txt" is the default.


.INPUTS
        
None. You cannot pipe objects to Add-Extension.


.OUTPUTS
        
System.String,

PowerShell-7.3.1-win-x64.msi install script starting...Written by DAM on 2023-01-19
Checking download link...
Download link good!
Downloading .msi installer for PowerShell-7.3.2-win-x64.msi...
Installing PowerShell-7.3.1-win-x64.msi...
PowerShell-7.3.1-win-x64.msi installer is running...Please wait
PowerShell-7.3.1-win-x64.msi installer is running...Please wait
PowerShell-7.3.1-win-x64.msi installed!


.LINK

[Write-Host](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-host?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.3)

[about_Operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)
 
[about_Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.3)

[Invoke-WebRequest](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.3)

[msiexec](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/msiexec)

[about_Do](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.3)

[Remove-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.3)

#>

#Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138

$ProgressPreference = 'SilentlyContinue'

#Program Path when its installed.

$ProgramPath = "C:\Program Files\PowerShell\7\pwsh.exe"

#Download URI

$URI = 'https://github.com/PowerShell/PowerShell/releases/download/v7.3.2/PowerShell-7.3.2-win-x64.msi'

#Full name of the installer.

$InstallerName = 'PowerShell-7.3.1-win-x64.msi'

#Out-File location. C:\TEMP is used as C:\ will not grant you access to by default.

$OutFile = "C:\$InstallerName"



Write-Host "$InstallerName install script starting...Written by DAM on 2023-01-19"


#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
    
}


#Checks to see if the program is already installed.

$TestPath = Test-Path -Path "$ProgramPath"

if ($TestPath -eq 'True') {

    Throw "$InstallerName is already installed..."

}



#Check if link is broken.

Write-Host "Checking download link..."

$InvokeWeb = Invoke-WebRequest -Method Head -URI "$URI" -UseBasicParsing

if ($InvokeWeb.StatusDescription -eq "OK") {
    Write-Host "Download link good!"
}else
{
    Throw "Check download link..."
}


#Downloads Program via web.

Write-Host "Downloading .msi installer for $InstallerName..."

Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing


#Install Program from URI.

Write-Host "Installing $InstallerName"

msiexec.exe /i "$OutFile" /quiet ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 ADD_PATH=1 ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_MU=1


#Ininstall check and TEMP file delete.

do { 
    $TestPath = Test-Path -Path "$ProgramPath"
    if ($TestPath -ne 'True') {
        Write-Host "$InstallerName installer is running...Please wait"
        
        Start-Sleep -Seconds 5

    }
} 
Until ($TestPath -eq 'True')

Write-Host "$InstallerName installed!"

Remove-Item "$OutFile"


