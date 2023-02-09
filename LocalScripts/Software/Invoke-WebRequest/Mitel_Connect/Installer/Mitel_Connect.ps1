#ReadMe
<#

ESET Endpoint Security installer
    
.SYNOPSIS

Downloads and installs ESET Endpoint Security installer if not already installed.


.Notes

Know CMD line switchs as of 2023-02-08.

/L : language ID
/S : Hide initialization diolog
/S /V/qn : Slient Mode
/V : Peramiters to MsiExec.exe
/UA <url to InsMsiA.exe>
/UW <url to InsMsiW.exe>
/UM <url to msi package>
/US <url to IsScript.msi>
  

.INPUTS
        
None.


.OUTPUTS
        
System.String,

ESET Endpoint Security installer script starting...Written by DAM on 2023-02-01
epi_win_live_installer.exe install script starting...Written by DAM on 2023-01-18
Checking download link...
Download link good!
Downloading .exe installer for epi_win_live_installer.exe...
Installing epi_win_live_installer.exe
epi_win_live_installer.exe installer is running...Please wait
epi_win_live_installer.exe installed!

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

[ESET Silent Install](https://support.eset.com/en/kb6820-deploy-the-eset-management-agent-and-the-eset-endpoint-product-together-7x)


#>


#Script

$ScriptName = 'Mitel Connect and Helper installer'



Write-Host "$ScriptName script starting...Written by DAM on 2023-02-08"




#Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138

$ProgressPreference = 'SilentlyContinue'

#Program Path when its installed.

$ProgramPath = "C:\Program Files (x86)\Mitel\Connect\Mitel.exe"

#Download URI

$URI = 'https://upgrade01.sky.shoretel.com/ClientInstall/NonAdmin'

#Full name of the installer.

$InstallerName = 'MitelConnect.exe'

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


#Downloads Program via web.

Write-Host "Downloading .exe installer for $InstallerName..."

Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing


#Install Program from URI.

Write-Host "Installing $InstallerName"

Start-Process -FilePath "$OutFile" -ArgumentList "--silent", "--accepteula"

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

Start-Sleep -Seconds 8

Remove-Item "$OutFile"



