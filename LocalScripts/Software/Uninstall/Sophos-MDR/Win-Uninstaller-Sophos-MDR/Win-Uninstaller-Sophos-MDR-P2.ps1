#ReadMe
<#

Win-Uninstaller-Sophos-MDR

.SYNOPSIS

Uinstalls Uninstall Sophos Interceptor X if not already uninstalled.

.Notes

.INPUTS

None.

.OUTPUTS

System.String,

VERBOSE: VS Windows Sophos Interceptor X Installer: Written by VS-DAM on 2023-10-26
VERBOSE: Uninstalling SophosUninstall.exe
VERBOSE: SophosUninstall.exe uninstalled!

.LINK

[Write-Verbose](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-verbose?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.3)

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3)

[about_Try_Catch_Finally](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.3)

[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3)

[about_Operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)

[about_Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.3)

[about_Do](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.3)

[Restart-Computer](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/restart-computer?view=powershell-7.3)

[Uninstall Sophos Interceptor X](https://support.sophos.com/support/s/article/KB-000035419?language=en_US)

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
        $ScriptAuthor = 'Written by VS-DAM on 2023-10-26'
    )
    #Script Introduction
    Write-Verbose -Message "$ScriptName $ScriptAuthor" -Verbose 
}

function Uninstall-SophosMDR {
    param(
        #Program Path when its installed.
        $ProgramPath = 'C:\Program Files\Sophos\Sophos Endpoint Agent',
        #Download Link
        $URI = 'https://download.sophos.com/tools/SophosZap.exe',
        #Full name of the installer.
        $UninstallerName = 'SophosZap.exe',
        #Out-File location.
        $OutFile = "C:\$UninstallerName"
    )
    #Uninstalls the Program.
    try {
        Write-Verbose -Message "Uninstalling $UninstallerName" -Verbose
        Set-Location -Path 'C:\'
        Start-Process -FilePath "$UninstallerName" -Verb RunAs -ArgumentList "--confirm"
        Start-Sleep -Seconds 180
        taskkill /f /im "$UninstallerName"
        #Runs twice as that is what was recomended to me by support.
        Set-Location -Path 'C:\'
        Start-Process -FilePath "$UninstallerName" -Verb RunAs -ArgumentList "--confirm"
        Start-Sleep -Seconds 180
        taskkill /f /im "$UninstallerName"
    }catch {
        Throw "Error[0]"
    }
    #TEMP file delete.
    try {
        Start-Sleep -Seconds 5
        Write-Verbose -Message "$UninstallerName removed" -Verbose
        Remove-Item "$OutFile"
    }catch {
    Throw "$Error[0]"
    }
    #Reboot device for uninstall cleanup
    try {
        Write-Verbose -Message "Forcing Computer Restart..."
        Restart-Computer -Force
    }catch {
        Write-Verbose -Message "Check to make sure this script is running elevated"
    }
}

Start-ScriptBoilerPlate

Uninstall-SophosMDR




