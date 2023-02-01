#ReadMe
<#

PS 7 LTS 7.2.8 web installer
    
.SYNOPSIS

Downloads and installs PowerShell 7 LST 7.2.8 if not already installed.


.Notes

Though the installer will say its done and installed, it will take 5 or so seconds for the PC to show the newly installed program via the start menu recently added.
  

.INPUTS
        
None.


.OUTPUTS
        
System.String,

PowerShell-7.2.8-win-x64.msi install script starting...Written by DAM on 2023-01-18
Checking download link...
Download link good!
Downloading .msi installer for PowerShell-7.2.8-win-x64.msi...
Installing PowerShell-7.2.8-win-x64.msi...
PowerShell-7.2.8-win-x64.msi installer is running...Please wait
PowerShell-7.2.8-win-x64.msi installed!


.LINK

[Write-Host](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-host?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.3)

[about_Operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)
 
[about_Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.3)

[Invoke-WebRequest](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.3)

[msiexec](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/msiexec)

[Installing PowerShell on Windows] (https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.3#msi)

[about_Do](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.3)

[Remove-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.3)

#>

#Script

$ScriptName = 'ESET Endpoint Security installer'



Write-Host "$ScriptName script starting...Written by DAM on 2023-02-01"




#Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138

$ProgressPreference = 'SilentlyContinue'

#Program Path when its installed.

$ProgramPath = "C:\Program Files\ESET\ESET Security\egui.exe"

#Download URI

$URI = 'https://redirector.eset.systems/li-handler/?uuid=epi_win-610c7183-5ef4-4225-9e6c-7baea47e00e6'

#Full name of the installer.

$InstallerName = 'epi_win_live_installer.exe'

#Out-File location. C:\TEMP is used as C:\ will not grant you access to by default.

$OutFile = "C:\$InstallerName"



Write-Host "$InstallerName install script starting...Written by DAM on 2023-01-18"


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




#Install Program from URI.

Write-Host "Installing $InstallerName"

msiexec.exe /i "$OutFile" /quiet ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 ADD_PATH=1 ENABLE_MU=1


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


