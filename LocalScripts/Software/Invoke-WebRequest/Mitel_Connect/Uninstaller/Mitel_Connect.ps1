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


#>


#Script




#Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138

$ProgressPreference = 'SilentlyContinue'

#Program Path when its installed.

$ProgramPath = "C:\Users\$env:UserName\AppData\Local\Programs\Mitel\Connect\Mitel.exe"

#Download URI

$URI = 'https://upgrade01.sky.shoretel.com/ClientInstall/NonAdmin'

#Full name of the installer.

$InstallerName = 'MitelConnect.exe'

#Out-File location. C:\TEMP is used as C:\ will not grant you access to by default.

$OutFile = "C:\$InstallerName"


#Script Authering 

$ScriptName = 'Mitel Connect installer'

$ScriptAuthor = 'DAM'

$LastModified = '2023-01-18'

Write-Host "$ScriptName install script starting...Written by $ScriptAuthor last modified on $LastModified"


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

try {
    Write-Host "Checking download link..."

    $InvokeWeb = Invoke-WebRequest -Method Head -URI "$URI" -UseBasicParsing
    
    if ($InvokeWeb.StatusDescription -eq "OK") {
        Write-Host "Download link good!" 
    
    }
}catch {
    Throw $Error[1]
}





#Downloads Program via web.

try {
    Write-Host "Downloading .exe installer for $InstallerName..."

    Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing
}catch {
    Throw $Error[1]
}


#Uninstall Program from URI.

try {
    Write-Host "Uninstalling $InstallerName"

    Start-Process -FilePath "$OutFile" -ArgumentList "/x","/S", "/V/qn"
}catch {
    Throw $Error[1]
}




#Ininstall check and TEMP file delete.
try {
    do { 
        $TestPath = Test-Path -Path "$ProgramPath"
        if ($TestPath -ne 'True') {
            Write-Host "$InstallerName installer is running...Please wait"
            
            Start-Sleep -Seconds 5
    
        }
    } 
    Until ($TestPath -eq 'True')
}catch {
    Throw $Error[1]
}finally {
    Start-Sleep -Seconds 8

    Write-Host "$InstallerName installed!"
    
    Remove-Item "$OutFile"<#Do this after the try block regardless of whether an exception occurred or not#>
}






