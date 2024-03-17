#ReadMe
<#

Power-Toys-.79-64Bit-Machine.ps1

.SYNOPSIS

Installs PowerToys ver .79 64Bit Machine wide.

.Notes

An elivated terminal and PS Ver 3.0 or higher is required.

.INPUTS

None.

.OUTPUTS

System.String,

VERBOSE: Power-Toys-.79-64Bit-Machine.ps1 script starting...written by DAM 2024-03-17, last modified Never
VERBOSE: The terminal is running as an Administrator...Continuing script...
Exception:
Line |
  15 |          Throw "$InstallerName is already installed..."
     |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | PowerToysUserSetup-0.79.0-x64.exe is already installed...

or

VERBOSE: Power-Toys-.79-64Bit-Machine.ps1 script starting...written by DAM 2024-03-17, last modified Never
VERBOSE: The terminal is running as an Administrator...Continuing script...
VERBOSE: The PowerSHell version is grater than 3.0...Continuing script...
VERBOSE: Downloading PowerToysUserSetup-0.79.0-x64.exe...
VERBOSE: Installing PowerToysUserSetup-0.79.0-x64.exe
VERBOSE: PowerToysUserSetup-0.79.0-x64.exe Installed!

.LINK

[Write-Verbose](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-verbose?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.4)

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3)

[about_Try_Catch_Finally](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.3)

[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3)

[about_Operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)

[about_Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.3)

[about_Do](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.3)

[PowerToys Download Site/URLs](https://github.com/microsoft/PowerToys/releases/tag/v0.79.0)

[PowerToys Installer Switches](https://learn.microsoft.com/en-us/windows/powertoys/install)

#>

#Script
#Region Start-Script
#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    param (
        $ScriptName = "Power-Toys-.79-64Bit-Machine.ps1",
        $ScriptAuthor = "DAM",
        $WrittenDate = "2024-03-17",
        $ModifiedDate = "Never",
        $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor $WrittenDate, last modified $ModifiedDate"
    )
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}
#Checks to see if the terminal is running as an administrator.
function Test-TerminalElevation {
    #Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
        Exit
    }else {
        Write-Verbose -Message "The terminal is running as an Administrator...Continuing script..." -Verbose
    }
}
#Checks to see if the software is already installed, if not, it installs it.
function Install-PowerToys64Bit {
    param (
        #Program Path when its installed.
        $ProgramPath = 'C:\Program Files\PowerToys',
        #Download Link
        $URI = 'https://github.com/microsoft/PowerToys/releases/download/v0.79.0/PowerToysSetup-0.79.0-x64.exe',
        #Full name of the installer.
        $InstallerName = 'PowerToysUserSetup-0.79.0-x64.exe',
        #Out-File location.
        $OutFile = "C:\$InstallerName"
    )
    #Checks to see if the program is already installed.
    $TestPath = Test-Path -Path "$ProgramPath"
    if ($TestPath -match 'True') {
        Throw "$InstallerName is already installed..."
    }else {
        #Ensures PowerShell 3.0 and higher is being used. Invoke-WebRequest is only able to run on PowerShell ver 3.0 and higher.
        if ($PSVersionTable.PSVersion.Major -ge "3") {
            Write-Verbose -Message "The PowerSHell version is grater than 3.0...Continuing script..." -Verbose
        }else {
            Throw "This scripts Invoke-WebRequest is only able to run on PowerShell ver 3.0 and higher."
        }
        #Downloads the latest exe.
        try {
            #Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
            $ProgressPreference = 'SilentlyContinue'
            Write-Verbose -Message "Downloading $InstallerName..." -Verbose
            Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing
        }catch {
            Write-Verbose -Message"$Error[0]" -Verbose
            Write-Verbose -Message"$InstallerName may not match what is being download anymore?" -Verbose
        }
        #Installs the Program.
        try {
            Write-Verbose -Message "Installing $InstallerName" -Verbose
            Start-Process -FilePath "$OutFile" -ArgumentList "/quiet"
            Start-Sleep -Seconds 10
            #Install check.
            try {
                do { 
                    $TestPath = Test-Path -Path "$ProgramPath"
                    if ($TestPath -eq 'True') {
                        Write-Verbose -Message "$InstallerName installer is running...Please wait" -Verbose
                        Start-Sleep -Seconds 8
                    }
                } 
                Until ($TestPath -ne 'True')
                Start-Sleep -Seconds 8
                Write-Verbose -Message "$InstallerName Installed!" -Verbose
            }catch {
                Write-Verbose -Message "Error[0]" -Verbose
            }
        }catch {
            Write-Verbose -Message "Error[0]" -Verbose
        }
    }
}
#Letting the user know what is starting.
Start-ScriptBoilerplate
#Checks to see if the terminal is running as an administrator.
Test-TerminalElevation
#Checks to see if the software is already installed, if not, it installs it.
Install-PowerToys64Bit

#EndRegion

