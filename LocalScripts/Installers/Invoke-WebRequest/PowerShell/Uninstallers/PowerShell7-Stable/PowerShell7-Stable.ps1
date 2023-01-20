#ReadMe
<#

PS 7 Stable 7.3.1 web Uninstaller
    
.SYNOPSIS

Downloads and installs PowerShell 7 Stable 7.3.1 if not already installed.

.PARAMETER Name
        
Specifies the file name.

    
.PARAMETER Extension
        
Specifies the extension. "Txt" is the default.


.INPUTS
        
None. You cannot pipe objects to Add-Extension.


.OUTPUTS
        
System.String,

PowerShell-7.3.1-win-x64.msi uninstall script starting...Written by DAM on 2023-01-19
Checking download link...
Download link good!
Downloading .msi installer for ...
PowerShell-7.3.1-win-x64.msi uninstaller is running...Please wait
PowerShell-7.3.1-win-x64.msi uninstalled!


.LINK

[Write-Host](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-host?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.3)

[about_Operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)

[Write-Error](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-error?view=powershell-7.3)
 
[about_Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.3)

[Test-NetConnection](https://learn.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection?view=windowsserver2022-ps)

[Invoke-WebRequest](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.3)

[msiexec](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/msiexec)

[about_Do](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.3)

[Remove-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.3)

#>


#Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here. (https://github.com/PowerShell/PowerShell/issues/2138)

$ProgressPreference = 'SilentlyContinue'

#Program Path when its installed.

$ProgramPath = "C:\Program Files\PowerShell\7\pwsh.exe"

#Download URI

$URI = 'https://github.com/PowerShell/PowerShell/releases/download/v7.3.1/PowerShell-7.3.1-win-x64.msi'

#Full name of the installer.

$InstallerName = 'PowerShell-7.3.1-win-x64.msi'

#Out-File location. C:\TEMP is used as C:\ will not grant you access to by default.

$OutFile = 'C:\TEMP'

#Changes the installers name to what it should of been. See $Outfile for why.

$OutFileReName = "C:\$InstallerName"



Write-Host "$InstallerName uninstall script starting...Written by DAM on 2023-01-19"


#Checks the PS terminal version this is ran in 5.X.X.

if ($PSVersionTable.PSVersion.Major -eq 5) {
	
}else {
		
	Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 5.X.X...Ending Script" -WarningAction Inquire
		
	}


#Checks if the terminal is running as admin.

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."

}


#Checks to see if the program is already uinstalled.

$TestPath = Test-Path -Path "$ProgramPath"

if ($TestPath -eq "False") {

}else {
    Throw "$InstallerName is already uinstalled..."
}


#Test if the .msi is still present, if not it re-downloads it.

$TestPath = Test-Path -Path "$OutfileRename"

if ($TestPath -eq 'False') {

}else {


#Check if link is broken.

Write-Host "Checking download link..."

$InvokeWeb = Invoke-WebRequest -Method Head -URI "$URI"

if ($InvokeWeb.StatusDescription -eq "OK") {
    Write-Host "Download link good!"
}else
{
    Throw "Check download link..."
}


#Downloads Program via web.

Write-Host "Downloading .msi installer for $ProgramPathShort..."

Invoke-WebRequest -URI "$URI" -OutFile "$OutFile"


#Rename download.

Rename-Item -Path "$OutFile" -NewName "$InstallerName"

Start-Sleep -Seconds 3

}


#Uninstalls the program.

MsiExec.exe /x "$OutfileRename" /quiet


#Uninstall check and TEMP file delete.

do { 
    $TestPath = Test-Path -Path "$ProgramPath"
    if ($TestPath -eq 'True') {
        Write-Host "$InstallerName uninstaller is running...Please wait"
        
        Start-Sleep -Seconds 5

    }
} 
Until ($TestPath -eq 'True')

Write-Host "$InstallerName uninstalled!"

Remove-Item "$OutFileReName"



