#ReadMe
<#
Cloud-Contact-Center-MXReport-4.2.1.25.ps1

.SYNOPSIS
Downloads and installs Windows MSI WebRoot Agent Installer if not already installed. It also will make sure another AV is not already installed.
That AV must be defined in the Install-WebRoot finction paramater.

.Notes

.INPUTS

None.

.OUTPUTS

System.String,

Start-ScriptBoilerPlate
VERBOSE: Cloud-Contact-Center-ZAC-Installer.ps1 Written by DAM on 2024-03-05

Install-MXReport
VERBOSE: Downloading .exe installer for MXReport-4.2.1.25.exe...
VERBOSE: Installing MXReport-4.2.1.25.exe
VERBOSE: MXReport-4.2.1.25.exe installer is running...Please wait
VERBOSE: MXReport-4.2.1.25.exe installed!
VERBOSE: MXReport-4.2.1.25.exe removed

or

MXReport-4.2.1.25.exe is already installed...C:\Program Files (x86)\Zultys\ZAC

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

[Accent's URL](Reach out to Accent as they provied the DL link and it seems not publically available)

#>

#Script

#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
}
#Script Boilerplate
function Start-ScriptBoilerPlate {
    [CmdletBinding()]
    param (
        #Script Name
        $ScriptName = 'Cloud-Contact-Center-MXReport-4.2.1.25.ps1',
        #Script Author
        $ScriptAuthor = 'Written by DAM on 2024-04-01'
    )
    #Script Introduction
    Write-Verbose -Message "$ScriptName $ScriptAuthor" -Verbose 
}
#Installs the Program from URI.
function Install-MXReport {
    param(
        #Program Path when its installed.
        $ProgramPath = 'C:\Program Files (x86)\Zultys\MXReport',
        #Download Link
        $URI = 'https://mirror.zultys.biz/mxreports/MXReport-4.2.1.25.exe',
        #Full name of the installer.
        $InstallerName = 'MXReport-4.2.1.25.exe',
        #Out-File location.
        $OutFile = "C:\$InstallerName"
    )
    $ExsistingInsatll = Test-Path -Path "$ProgramPath"
    if ($ExsistingInsatll -match 'True') {
        Write-Verbose -Message "$InstallerName is already installed...$ProgramPath" -Verbose
    }
    else {
        #Downloads the latest msi.
        try {
            #Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
            $ProgressPreference = 'SilentlyContinue'
            Write-Verbose -Message "Downloading .exe installer for $InstallerName..." -Verbose
            Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing
        }catch {
            Write-Verbose -Message"$Error[0]" -Verbose
            Write-Verbose -Message"$InstallerName may not match what is being download anymore?" -Verbose
            Write-Verbose -Message"Invoke-WebRequest is not supported on Win 7..." -Verbose
        }
        #Installs the Program from URI.
        try {
            Write-Verbose -Message "Installing $InstallerName" -Verbose
            Start-Process -FilePath "$OutFile" -ArgumentList "/S /v/qn -Install"
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
                Write-Verbose -Message "$Error[0]" -Verbose
            }
        }catch {
            Write-Verbose -Message "$Error[0]" -Verbose
        }
    }
}
#Script Boilerplate
Start-ScriptBoilerPlate
#Installs the Program from URI.
Install-MXReport


