$ErrorActionPreference = "Stop"

$ProgramPath = 'C:\Program Files\PowerShell\7\pwsh.exe'

$ProgramPathShort = $ProgramPath.TrimStart("C:\Program Files\PowerShell\7\")


$URI = 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.8/PowerShell-7.2.8-win-x64.msi'


$URIShort = $URI.TrimStart("https://github.com/PowerShell/PowerShell/releases/download")


$OutFile = 'C:\TEMP'


#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    Write-Error "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
    
}


#Checks to see if the program is already installed.

if (Test-Path -Path $ProgramPath) {

}else {
    Throw "'$ProgramPathShort' is alreay installed..."
}


Write-Host "$URIShort installer is starting"


Write-Host "Checking network connection..."

#Checks Ethernet Connection/ability to dial out.

$NetworkConnection = Test-NetConnection | Select-Object 'PingSucceeded'

if ($NetworkConnection -match 'True')
{
    Write-Host "Network connection confirmed!"
}else {
    Throw "Check network connection..."
}


#Test download link

Write-Host "Checking download link..."

if (Test-Connection -TargetName "$URI")
{
    Write-Host "Download link good!"
}else
{
    Throw "Check download link..."
}


Invoke-WebRequest -URI "https://github.com/PowerShell/PowerShell/releases/download/v7.2.8/PowerShell-7.2.8-win-x64.msi" -StatusCodeVariable "scv"

$response = Invoke-WebRequest -Uri "https://github.com/PowerShell/PowerShell/releases/download/v7.2.8/PowerShell-7.2.8-win-x64.msi"
$response


#Install PS 7 LST from githubs URL

Invoke-WebRequest -URI "$URI" -OutFile '$OutFile'

msiexec.exe /i "$OutFile" /quiet



#Post install TEMP file delete

if (Test-Path -Path 'C:\Program Files\PowerShell\7\pwsh.exe') {
    
    Remove-Item "$OutFile"

}









