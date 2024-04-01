#ReadMe
<#

Power-Toys-.79-64Bit-Machine.ps1

.SYNOPSIS

Installs PowerToys ver .79 64-Bit Machine wide.

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

[Start-Process](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-7.4)

[GIT Download Site/URLs](https://git-scm.com/download/win)

[GIT Installer Switches](https://github.com/git-for-windows/git/wiki/Silent-or-Unattended-Installation)

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
        $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor $WrittenDate, last modified $ModifiedDate."
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
function Install-Software {
    param (
        #Program Path when its installed.
        $ProgramPath = "C:\Program Files\Git",
        #Download Link
        $URI = 'https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe',
        #Full name of the installer.
        $InstallerName = 'Git-2.44.0-64-bit.exe',
        #Out-File location.
        $OutFile = "C:\$InstallerName"
    )
    #Checks to see if the program is already installed.
    $TestPath = Test-Path -Path "$ProgramPath"
    if ($TestPath -match 'True') {
        Throw "Another version of GIT is already installed..."
    }else {
        #Ensures PowerShell 3.0 and higher is being used. Invoke-WebRequest is only able to run on PowerShell ver 3.0 and higher.
        if ($PSVersionTable.PSVersion.Major -ge "3") {
            Write-Verbose -Message "The PowerSHell version is grater than 3.0...Continuing script..." -Verbose
        }else {
            Throw "This scripts Invoke-WebRequest is only able to run on PowerShell ver 3.0 and higher."
        }
        #Checks to see if Visual Studio Code is already install as the GIT Config below requires it per its EditorOption=VisualStudioCode.
        #Checks for the default install path for VSCode
        $TestPath2 = Test-Path -Path 'C:\Program Files\Microsoft VS Code'
        if ($TestPath2 -match "True") {
            Write-Verbose -Message "VSCode is already installed...Continuing script..." -Verbose
        }else {
            Throw "Visual Studio Code is not install... This script GIT Config below requires it per its EditorOption=VisualStudioCode...Please installer it first..."
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
        #Creates the configuration files for the install.
        try {
            #Creates the config file.
            New-Item -Path "C:\" -Name "git_options.ini" -ItemType "file"
            #Adds the Git's config settings to the file.
            #Adds the require [Setup] header. 
            Add-Content -Path "C:\git_options.ini" -Value "[Setup]"
            #Windows Comonents to install.
            Add-Content -Path "C:\git_options.ini" -Value "Components=gitlfs,assoc,assoc_sh,windowsterminal"
            #Makes VSCode the default editor.
            Add-Content -Path "C:\git_options.ini" -Value "EditorOption=VisualStudioCode"
            #Adjusting the name of the initial branch in new repos - Overrites the default branch name for new repos as main.
            Add-Content -Path "C:\git_options.ini" -Value "DefaultBranchOption=main"
            #Adjusting your PATH enviroment - Git from the cmd line and also from 3rd-pary software.
            Add-Content -Path "C:\git_options.ini" -Value "PathOption=Cmd"
            #Choosing the SSH executable - Uses external OpenSSH.
            Add-Content -Path "C:\git_options.ini" -Value "SSHOption=OpenSSH"
            #Choosing HTTPS transport backend - Use the OpenSSL library.
            Add-Content -Path "C:\git_options.ini" -Value "CURLOption=OpenSSL"
            #Configure the line ending converstions - Checkout Windows-style, commit Unix-style line endings.
            Add-Content -Path "C:\git_options.ini" -Value "CRLFOption=LFOnly"
            #Configure the termianl emulator to use with git bach - Uses the Windows' default console window.
            Add-Content -Path "C:\git_options.ini" -Value "BashTerminalOption=ConHost"
            #Default behavior of git pull - fast-forward or merger.
            Add-Content -Path "C:\git_options.ini" -Value "GitPullBehaviorOption=Merge"
            #Chose a credential helper - Git Cred Manager.
            Add-Content -Path "C:\git_options.ini" -Value "UseCredentialManager=Enabled"
            #Configurating extra options - Enable File system caching.
            Add-Content -Path "C:\git_options.ini" -Value "PerformanceTweaksFSCache=Enabled"
        }catch {
            Write-Verbose -Message "Error[0]" -Verbose
        }
        #Installs the Program.
        try {
            Write-Verbose -Message "Installing $InstallerName" -Verbose
            Start-Process -FilePath "$OutFile" -ArgumentList "/VERYSILENT", "/NORESTART", "/LOADINF=git_options.ini"
            Start-Sleep -Seconds 10
            #Install check.
            try {
                do { 
                    $TestPath = Test-Path -Path "$ProgramPath"
                    if ($TestPath -ne 'True') {
                        Write-Verbose -Message "$InstallerName installer is running...Please wait" -Verbose
                        Start-Sleep -Seconds 8
                    }
                } 
                Until ($TestPath -match 'True')
                Start-Sleep -Seconds 8
                Write-Verbose -Message "$InstallerName Installed!" -Verbose
                Remove-Item -Path "$OutFile"
                Remove-Item -Path "C:\git_options.ini"
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
Install-Software

#EndRegion

