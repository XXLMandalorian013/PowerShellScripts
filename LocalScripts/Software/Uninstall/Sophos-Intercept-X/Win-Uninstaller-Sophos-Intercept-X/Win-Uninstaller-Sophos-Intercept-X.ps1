#ReadMe
<#

Win-Uninstaller-Sophos-Intercept-X

.SYNOPSIS

Uinstalls Sophos Interceptor X if not already uninstalled.

.Notes

Not all uninstalls are cleanly done and may required a second pass of this script or manual removal.

.INPUTS

None.

.OUTPUTS

System.String,

WIN Sophos Interceptor X Removal
VERBOSE: Windows Sophos Interceptor X Installer:.ps1 script starting...written 
by DAM on 2023-10-16, last modified on 2024-02-29
VERBOSE: Uninstalling SophosUninstall.exe
VERBOSE: SophosUninstall.exe uninstalled!
Get-ChildItem : Cannot find path 'C:\Program Files\Sophos' because it does not exist.
VERBOSE: Forcing Computer Restart...

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
#Region Start-Script
#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    $ScriptName = "Windows Sophos Interceptor X Installer:.ps1"
    $ScriptAuthor = "DAM"
    $WrittenDate = "2023-10-16"
    $ModifiedDate = "2024-02-29"
    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor on $WrittenDate, last modified on $ModifiedDate"
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}
#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
}
#Uninstalls the newset AV.
function Uninstall-SophosInterceptXNew {
    param (
        #Program Path when its installed (newer insaller).
        $ProgramPath = 'C:\Program Files\Sophos\Sophos Endpoint Agent',
        #Full name of the installer (newer insaller).
        $UninstallerName = 'SophosUninstall.exe',
        #Full path of the uninstallers (new installer).
        $UninstallersFullPath = "$ProgramPath\$UninstallerName",
        #The base folder for any sophos instlled software
        $SophosBasePath = 'C:\Program Files\Sophos'
    )
    #Checks to see if the program is installed.
    $TestPath = Test-Path -Path "$UninstallersFullpath"
    if ($TestPath -match 'True') {
        #Uninstalls the Program.
        try {
            Write-Verbose -Message "Uninstalling $UninstallerName" -Verbose
            Set-Location -Path "$ProgramPath"
            Start-Process -FilePath "$UninstallerName" -ArgumentList "--quiet"
            Start-Sleep -Seconds 600
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
                Write-Verbose -Message "Checking to see if anything was left behind..."
                Get-ChildItem -Path "$SophosBasePath"
                #Reboot device for uninstall cleanup
                try {
                    Write-Verbose -Message "Forcing Computer Restart..." -Verbose
                    Restart-Computer -Force
                }catch {
                    Write-Verbose -Message "Could not reboot, check to make sure this script is running elevated" -Verbose
                }
            }catch {
                Write-Verbose -Message "Error[0]" -Verbose
            }
        }catch {
            Write-Verbose -Message "Error[0]" -Verbose
        }
    }else {
        Write-Verbose -Message "$UninstallerName not found and could already be uninstalled...Checking old lcation at $UninstallerNameOld" -Verbose
    }
}
#Uninstalls the older AV.
function Uninstall-SophosInterceptXOld {
    param (
        #Program Path when its installed (Older Install).
        $ProgramPathOld = 'C:\Program Files\Sophos\Sophos Endpoint Agent',
        #Full name of the installer (older insaller).
        $UninstallerNameOld = 'uninstallcli.exe',
        #Full path of the uninstallers (old installer).
        $UninstallersFullPath = "$ProgramPathOld\$UninstallerNameOld",
        #Program Path when its installed (newer insaller).
        $ProgramPath = 'C:\Program Files\Sophos\Sophos Endpoint Agent',
        #The base folder for any sophos instlled software
        $SophosBasePath = 'C:\Program Files\Sophos'
    )
    #Checks to see if the program is already uninstalled.
    $TestPath = Test-Path -Path "$ProgramPathOld"
    if ($TestPath -match 'True') {
        #Uninstalls the Program.
        try {
            Write-Verbose -Message "Uninstalling $UninstallerNameOld" -Verbose
            Set-Location -Path "$ProgramPathOld"
            Start-Process -FilePath "$UninstallerNameOld"
            Start-Sleep -Seconds 600
            #Uninstall check.
            try {
                do { 
                    $TestPath = Test-Path -Path "$ProgramPathOld"
                    if ($TestPath -eq 'True') {
                        Write-Verbose -Message "$UninstallerNameOld unistaller is running...Please wait" -Verbose
                        Start-Sleep -Seconds 5
                    }
                }Until ($TestPath -ne 'True')
                Write-Verbose -Message "$UninstallerNameOld uninstalled!" -Verbose
                Write-Verbose -Message "Checking to see if anything was left behind..."
                Get-ChildItem -Path "$SophosBasePath"
                #Reboot device for uninstall cleanup
                try {
                    Write-Verbose -Message "Forcing Computer Restart..." -Verbose
                    Restart-Computer -Force
                }catch {
                    Write-Verbose -Message "Check to make sure this script is running elevated" -Verbose
                }
            }catch {
                Write-Verbose -Message "Error[0]" -Verbose
            }
        }catch {
            Write-Verbose -Message "Error[0]" -Verbose
        }
        }else {
            Write-Verbose -Message "$UninstallerNameOld not found and could already be uninstalled...the uninstall may have been currupt...Displaying posible uninstall paths to check" -Verbose
            Get-ChildItem -Path "$SophosBasePath"
        }
}
#Letting the user know what is starting.
Start-ScriptBoilerplate
#Uninstalls the newset AV.
Uninstall-SophosInterceptXNew
#Uninstalls the older AV.
Uninstall-SophosInterceptXOld
#EndRegion

