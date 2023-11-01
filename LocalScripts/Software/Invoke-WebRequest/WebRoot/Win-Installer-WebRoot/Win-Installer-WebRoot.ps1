#ReadMe
<#
Windows MSI WebRoot Agent Installer.
.SYNOPSIS
Downloads and installs Windows MSI WebRoot Agent Installer if not already installed. It also will make sure another AV is not already installed.
That AV must be defined in the Install-WebRoot finction paramater.

.Notes

.INPUTS

None.

.OUTPUTS

System.String,

VERBOSE: VS Windows MSI WebRoot Agent Installer: Written by VS-DAM on 2023-10-12
VERBOSE: Checking download link...
VERBOSE: Download link good!
VERBOSE: Downloading .exe installer for wsasme.msi...
VERBOSE: Installing wsasme.msi
VERBOSE: wsasme.msi installed!
VERBOSE: wsasme.msi removed

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

[WebRoot: Deploying Agents](https://docs.webroot.com/us/en/business/administratorguide/administratorguide.htm#1_Admin%20and%20Getting%20Started%20Guide/Deploying%20agents.htm)

#>

#Script

#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
}

function Start-ScriptBoilerPlate {
    [CmdletBinding()]
    param (
        #Script Name
        $ScriptName = 'VS Windows MSI WebRoot Agent Installer:',
        #Script Author
        $ScriptAuthor = 'Written by VS-DAM on 2023-10-12'
    )
    #Script Introduction
    Write-Verbose -Message "$ScriptName $ScriptAuthor" -Verbose 
}

function Install-WebRoot {
    param(
        #Program Path when its installed.
        $ProgramPath = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Webroot SecureAnywhere',
        #Download Link
        $URI = 'https://anywhere.webrootcloudav.com/zerol/wsasme.msi',
        #Full name of the installer.
        $InstallerName = 'wsasme.msi',
        #Out-File location.
        $OutFile = "C:\$InstallerName",
        #Client Specific install key.
        $InstallKey = '123-456-789-123-456',
        #Other AV's install location.
        $OldAV = 'C:\Program Files\Sophos\Sophos Endpoint Agent'
    )
    #Checks if another AV is already installed.
    $TestPath = Test-Path -Path "$OldAV"
    if ($TestPath -eq 'True') {
        Throw "$OldAV is still installed..."
    }
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
        #Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
        $ProgressPreference = 'SilentlyContinue'
        Write-Verbose -Message "Downloading .exe installer for $InstallerName..." -Verbose
        Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing
    }catch {
        Throw "$Error[0]"
    }
    #Installs the Program from URI.
    try {
        Write-Verbose -Message "Installing $InstallerName" -Verbose
        $arguments = "/i $OutFile GUILIC=$InstallKey CMDLINE=SME,quiet /qn"
        Start-Process msiexec.exe -ArgumentList $arguments -Wait
    }catch {
        Throw "$Error[0]"
    }
    #Ininstall check and TEMP file delete.
    try {
        do { 
            $TestPath = Test-Path -Path "$ProgramPath"
            if ($TestPath -ne 'True') {
                Write-Verbose -Message "$InstallerName installer is running...Please wait" -Verbose
                Start-Sleep -Seconds 5
            }
        }Until ($TestPath -eq 'True')
            Write-Verbose -Message "$InstallerName installed!" -Verbose
            Start-Sleep -Seconds 5
            Write-Verbose -Message "$InstallerName removed" -Verbose
            Remove-Item "$OutFile"
    }catch {
        Throw "$Error[0]"
    }
}

Start-ScriptBoilerPlate

Install-WebRoot


