#ReadMe
<#

PS 7 LTS 7.2.8 web installer
    
.SYNOPSIS

Downloads and installs PowerShell 7 LST 7.2.8 if not already installed.

.PARAMETER Name
        
Specifies the file name.

    
.PARAMETER Extension
        
Specifies the extension. "Txt" is the default.


.INPUTS
        
None. You cannot pipe objects to Add-Extension.


.OUTPUTS
        
System.String. Add-Extension returns a string with the extension or file name.


.LINK
        
[String.TrimStart Method](https://learn.microsoft.com/en-us/dotnet/api/system.string.trimstart?view=net-7.0) 

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

$ErrorActionPreference = "Stop"


$ProgramPath = "C:\Program Files\PowerShell\7\pwsh.exe"


$ProgramPathShort = $ProgramPath.TrimStart("C:\Program Files\PowerShell\7\")


$URI = 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.8/PowerShell-7.2.8-win-x64.msi'


$URIShort = $URI.TrimStart("https://github.com/PowerShell/PowerShell/releases/download")


$OutFile = 'C:\TEMP'



Write-Host "$ProgramPathShort install script starting...Written by DAM on 2023-01-18"


#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    Write-Error "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
    
}


#Checks to see if the program is already installed.

$TestPath = Test-Path -Path "$ProgramPath"

if ($TestPath -eq 'True') {

    Throw "$ProgramPathShort is already installed..."

}


#Checks Ethernet Connection/ability to dial out.

Write-Host "Checking network connection..."

$NetworkConnection = Test-NetConnection | Select-Object 'PingSucceeded'

if ($NetworkConnection -match 'True')
{
    Write-Host "Network connection confirmed!"
}else {
    Throw "Check network connection..."
}


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


#Install Program from URL.

Write-Host "Installing $ProgramPathShort..."

msiexec.exe /i "$OutFile" /quiet ENABLE_PSREMOTING=1


#Post install TEMP file delete

do { 
    $TestPath = Test-Path -Path "$ProgramPath"
    if ($TestPath -ne 'True') {
        Write-Host "$URIShort installer is running...Please wait"
        
        Start-Sleep -Seconds 5

    }
} 
Until ($TestPath -eq 'True')

Write-Host "$ProgramPathShort installed!"

Remove-Item "$OutFile"



#LogFile

$Errors = _$

_$ | Out-File -FilePath $OutFile


