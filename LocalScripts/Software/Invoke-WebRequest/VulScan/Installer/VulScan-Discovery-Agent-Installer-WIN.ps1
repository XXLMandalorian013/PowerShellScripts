#ReadMe
<#

Demask-Holdings Windows MSI VulScan Discovery Agent Installer

.SYNOPSIS

Downloads and installs Windows MSI VulScan Discovery Agent Installer if not already installed.

.Notes

.INPUTS

None.

.OUTPUTS

System.String,

VERBOSE: VS Windows MSI VulScan Discovery Agent Installer: Written by VS-DAM on 2023-10-12
VERBOSE: Checking download link...
VERBOSE: Download link good!
VERBOSE: Downloading .exe installer for DiscoveryAgent.msi...
VERBOSE: Installing DiscoveryAgent.msi
VERBOSE: DiscoveryAgent.msi installed!
Configuring with the following ID: AGT-73YYCJ
Forcing an update to the lastest. This will run outside this installer.
If you see the services go up and down it is due to the forced update.
Creating location file...
Success.
Configuration complete.

.LINK

[Write-Verbose](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-verbose?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.3)

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3)

[about_Try_Catch_Finally](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.3)

[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3)

[about_Operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)

[about_Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.3)

[Invoke-WebRequest](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.3)

[msiexec](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/msiexec)

[about_Do](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.3)

[Remove-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.3)

[VulScan Silent Install See PG 234](https://www2.rapidfiretools.com/nd/Network_Detective_Pro_User_Guide.pdf)

#>

#Script

#Script Name
$ScriptName = 'VS Windows MSI VulScan Discovery Agent Installer:'

#Script Author
$ScriptAuthor = 'Written by VS-DAM on 2023-10-12'

#Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
$ProgressPreference = 'SilentlyContinue'

#Program Path when its installed.
$ProgramPath = 'C:\Program Files (x86)\DiscoveryAgent'

#Download Link
$URI = 'https://download.rapidfiretools.com/download/DiscoveryAgent.msi'

#Full name of the installer.
$InstallerName = 'DiscoveryAgent.msi'

#Out-File location.
$OutFile = "C:\$InstallerName"

#Client Specifiy install key.
$InstallKey = '1234-acvd-1234-asdf-1q2w3e4r5t'

#Client Name.
$CompanyName = 'VS'

#Define computer host type: Physical or Hypervisor name ie VCD, Hyper-V.
$HostType = 'Physical'

#Lable Var. Do not change this var, only $CompanyName & $HyperVisorName shouldbe changed above.
$Lable = "$CompanyName-$HostType-$env:computername-VulScan-Descov-Agent"

#Lable Var. Do not change this var, only $CompanyName & $HyperVisorName shouldbe changed above.
$Comment = "$CompanyName-$HostType-$env:computername-VulScan-Descov-Agent"

#Script Introduction
Write-Verbose -Message "$ScriptName $ScriptAuthor" -Verbose

#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
}

function Install-VulScanDiscovAgent {
    
    #Checks to see if the program is already installed.
    $TestPath = Test-Path -Path "$ProgramPath"

    if ($TestPath -eq 'True') {

        Throw "$InstallerName is already installed..."
    }

    #Check if the downlaod link is broken.
    Write-Verbose -Message "Checking download link..." -Verbose

    $InvokeWeb = Invoke-WebRequest -Method Head -URI "$URI" -UseBasicParsing

    if ($InvokeWeb.StatusDescription -eq "OK") {
        Write-Verbose -Message "Download link good!" -Verbose
    }else
    {
        Throw "Check download link..."
    }

    #Downloads the latest msi.
    try {
        Write-Verbose -Message "Downloading .exe installer for $InstallerName..." -Verbose

        Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing
    }
    catch {
        Throw "Error[0]"
    }

    #Installs the Program from URI.
    try {
        Write-Verbose -Message "Installing $InstallerName" -Verbose

        $arguments = "/i $OutFile /quiet"
        Start-Process msiexec.exe -ArgumentList $arguments -Wait
    }
    catch {
        Throw "Error[0]"
    }

    #Ininstall check and TEMP file delete.
    try {
        do { 
            $TestPath = Test-Path -Path "$ProgramPath"
            if ($TestPath -ne 'True') {
                Write-Verbose -Message "$InstallerName installer is running...Please wait" -Verbose
            
                Start-Sleep -Seconds 5
    
            }
        } 
        Until ($TestPath -eq 'True')
    
        Write-Verbose -Message "$InstallerName installed!" -Verbose
    
        Start-Sleep -Seconds 5
    
        Remove-Item "$OutFile"
    }
    catch {
        Throw "Error[0]"
    }

    #Sets install key, label and comment.
    try {
        Set-Location -Path 'C:\Program Files (x86)\DiscoveryAgent\Agent\bin'
        & .\register-device.exe -installkey "$InstallKey" -label "$Lable" -comment "$Comment"
    }catch {
        Throw "Error[0]"
    }
}

Install-VulScanDiscovAgent


