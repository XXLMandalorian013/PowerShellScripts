#ReadMe
<#

Win-Installer-CytracomDesktop.ps1

.SYNOPSIS

Installs CytracomDesktop if not already uninstalled.

.Notes

An elivated terminal and PS Ver 3.0 or higher is required.

.INPUTS

None.

.OUTPUTS

System.String,

#>
#Script
#Region Start-Script
#Vars
#TMP install folder location.
$TMPInstallerFolderLocation = "C:"
#TMP install folder.
$TempInstallFolder = "TMP-Installer-99"
#Program Path when its installed.
$ProgramPath = "C:\Users\$env:UserName\AppData\Local\Programs\Cytracom Desktop\Cytracom Desktop.exe"
#Download Link
$URI = "https://cdn.cytracom.com/cdesktop/cdesktop-win.exe"
#Full name of the installer.
$InstallerName = "cdesktop-win.execdesktop-win.exe"
#Out-File location.
$OutFile = "$TMPInstallerFolderLocation\$TempInstallFolder\$InstallerName"
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
#Creates the TMP folder if it does not already exsist.
function New-TMPFolder {
    #Creates the TMP folder if it does not already exsist.
    if (Test-Path -Path "$TMPInstallerFolderLocation\$TempInstallFolder") {
        Write-Verbose -Message "'$TMPInstallerFolderLocation\$TempInstallFolder' exsist...continuing script..." -Verbose
    }else {
        Write-Verbose -Message "'$TMPInstallerFolderLocation\$TempInstallFolder' does not exsist...creating temp folder..." -Verbose
        New-Item -Path "$TMPInstallerFolderLocation\$TempInstallFolder" -ItemType "Directory"
    }
}
#Checks to see if the software is already installed, if not, it installs it.
function Install-Software {
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
            Start-Process -FilePath "$OutFile" -ArgumentList "/S"
            Start-Sleep -Seconds 10
            #Install check.
            try {
                do {
                    $TestPath = Test-Path -Path "$ProgramPath"
                    if (-not $TestPath) {
                        Write-Verbose -Message "$InstallerName installer is running...Please wait" -Verbose
                        Start-Sleep -Seconds 8
                    }
                } until ($TestPath)
                    Start-Sleep -Seconds 8
                    Write-Verbose -Message "$InstallerName Installed!" -Verbose
                Remove-Item -Path "$OutFile" -Force
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
#Creates the TMP folder if it does not already exsist.
New-TMPFolder
#Checks to see if the software is already installed, if not, it installs it.
Install-Software
#EndRegion


