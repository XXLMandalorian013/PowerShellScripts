#ReadMe
<#

Office-Uninstaller.ps1

.SYNOPSIS

Uninsatll all office.

.Notes

None.

.INPUTS

None.

.OUTPUTS

System.String,



.LINK

[Write-Verbose](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-verbose?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.3)

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3)

[about_Try_Catch_Finally](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.3)

[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3)

[about_Operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)

[about_Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.3)

[about_Do](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.3)

[Expand-Archive](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.archive/expand-archive?view=powershell-7.4)

[New-Item] (https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.4)

[Office Uninstaller MS SaRA Tool](https://woshub.com/complete-uninstall-previous-office-versions/)

[SaRA Commands] (https://learn.microsoft.com/en-us/microsoft-365/troubleshoot/administration/assistant-office-uninstall)

#>

#Script
#Region Start-Script
#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    $ScriptName = "Office-Uninstaller.ps1"
    $ScriptAuthor = "DAM"
    $WrittenDate = "2024-09-13"
    $ModifiedDate = "never"
    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor on $WrittenDate, last modified on $ModifiedDate"
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}
#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
}
function Uninstall-Office {
    param (
        #Uninstall URL
        $URI = "https://aka.ms/SaRA_CommandLineVersionFiles", 
        #Base path.
        $BasePath1 = 'C:',
        #Unistaller folder
        $UninstallerFolder = "OfficeUninstaller",
        #Full name of the installer.
        $UninstallerName = 'SaRACmd_17_0_9663_9.zip',
        #-OutFile path for invoke-webrequest
        $OutFile = "C:\$UninstallerFolder\$UninstallerName",
        #Uninstaller Executable
        $UninstallEXE = "SaRAcmd.exe"
    )
    #Creates the uninstaller folder
    cd C:\
    $TestPath = Test-Path -Path "$BasePath1\$UninstallerFolder" -ErrorAction SilentlyContinue
    try {
        if ("$TestPath" -match "True") {
            
        }
        else {
            Write-Verbose -Message "Creating uninstaller folder..." -Verbose
            New-Item -Path "$BasePath1" -Name "$UninstallerFolder" -ItemType "Directory"
            Start-Sleep -Seconds 8
        }
    }
    catch {
        Write-Verbose -Message"$Error[0]" -Verbose
    }
    #Downloads the uninstaller zip.
    try {
        #Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
        $ProgressPreference = 'SilentlyContinue'
        Write-Verbose -Message "Downloading $UninstallerName..." -Verbose
        Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing
    }catch {
        Write-Verbose -Message"$Error[0]" -Verbose
        Write-Verbose -Message"$UninstallerName may not match what is being download anymore?" -Verbose
    }
    #Unzips the uninstaller.
    try {
        Start-Sleep -Seconds 5
        Set-Location -Path "$BasePath1\$UninstallerFolder"
        Write-Verbose -Message "Unzipping the folder..." -Verbose
        Expand-Archive -Path "$UninstallerName" -DestinationPath "$BasePath1\$UninstallerFolder"
    }
    catch {
        Write-Verbose -Message "$Error[0]" -Verbose
    }
    #Runs the uninstaller
    try {
        Set-Location -Path "$BasePath1\$UninstallerFolder"
        Start-Process -FilePath "$UninstallEXE" -ArgumentList "-S OfficeScrubScenario","-AcceptEula","-OfficeVersion All"
        Start-Sleep -Seconds 360
        taskkill /f /im $UninstallEXE
    }
    catch {
        Write-Verbose -Message"$Error[0]" -Verbose
    }
    #Removed the files.
    $TestPath = Test-Path -Path "$BasePath1\$UninstallerFolder" -ErrorAction SilentlyContinue
    try {
        if ("$TestPath" -match "True") {
            Remove-Item -Path "$BasePath1\$UninstallerFolder" -Recurse -Force -ErrorAction SilentlyContinue
        }
        else {
            
        }
    }
    catch {
        Write-Verbose -Message"$Error[0]" -Verbose
    }
}
#Letting the user know what is starting.
Start-ScriptBoilerplate
#Uninstalls the program.
Uninstall-Office
#EndRegion
