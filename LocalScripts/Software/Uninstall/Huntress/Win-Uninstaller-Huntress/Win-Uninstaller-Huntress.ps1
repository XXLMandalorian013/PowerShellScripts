#ReadMe
<#

Win-Uninstaller-Sophos-Intercept-X

.SYNOPSIS

Uinstalls Uninstall Sophos Interceptor X if not already uninstalled.

.Notes

.INPUTS

None.

.OUTPUTS

System.String,

VERBOSE: VS Windows Sophos Interceptor X Installer: Written by VS-DAM on 2023-10-16
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

[Uninstalling-the-Huntress-Agent](https://support.huntress.io/hc/en-us/articles/4404005116435-Uninstalling-the-Huntress-Agent)

#>
#Script
#Script Name
$ScriptName = 'VS Windows Huntress Installer:'
#Script Author
$ScriptAuthor = 'Written by VS-DAM on 2024-01-19'
#Program Path when its installed.
$ProgramPath = 'C:\Program Files\Huntress'
#Full name of the installer.
$UninstallerName = 'Uninstall.exe'
#Huntress Agent
$HuntressAgent = 'HuntressAgent.exe'
#Huntress Agent Updater
$HuntressUpdateAgent = 'HuntressUpdater.exe'
#Script Introduction
Write-Verbose -Message "$ScriptName $ScriptAuthor" -Verbose
#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
}
#Uninstalls Huntress
function Uninstall-Huntress {
    #Checks to see if the program is already uninstalled or not in its uninstaller is missing and tries to find
    $TestPath = Test-Path -Path "$ProgramPath"
    if ($TestPath -match 'False') {
        try {
            $TestPath = Test-Path -Path "$ProgramPath"
            if ($TestPath -match 'True') {
                Write-Verbose -Message "$ProgramPath\$UninstallerName is not found...Starting alternative removal" -Verbose
                Set-Location -Path "$ProgramPath"
                Start-Process -FilePath "$HuntressAgent" -ArgumentList "uninstall"
                Start-Sleep -Seconds 15
                Set-Location -Path "$ProgramPath"
                Start-Process -FilePath "$HuntressUpdateAgent" -ArgumentList "uninstall"
                Start-Sleep -Seconds 15
                Remove-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE' -Name 'Huntress Labs' -Force
                Write-Verbose -Message "$Error" -Verbose
            }else {
                Write-Verbose -Message "Huntress $HuntressAgent is not installed...ending script" -Verbos
            }
        }catch {
            Write-Verbose -Message "$Error" -Verbose
        }
    }
    #Uninstalls the Program.
    try {
        Write-Verbose -Message "Uninstalling $UninstallerName" -Verbose
        Set-Location -Path "$ProgramPath"
        Start-Process -FilePath "$UninstallerName" -ArgumentList "/S"
    }
    catch {
        Throw "Error[0]"
    }
    #Uninstall check.
    try {
        do { 
            $TestPath = Test-Path -Path "$ProgramPath"
            if ($TestPath -eq 'True') {
                Write-Verbose -Message "$UninstallerName unistaller is running...Please wait" -Verbose
                Start-Sleep -Seconds 5
            }
        } 
        Until ($TestPath -ne 'True')
        Write-Verbose -Message "$UninstallerName uninstalled!" -Verbose
    }
    catch {
        Throw "Error[0]"
    }
}
Uninstall-Huntress

