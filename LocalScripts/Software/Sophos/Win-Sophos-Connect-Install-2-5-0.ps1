#ReadMe
<#
Win-Sophos-Connect-Install-2-5-0.ps1
.SYNOPSIS
Installs the Sophos Connect Client 2.5.0.
#>
#Region Start-Script
#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    param (
        $ScriptName = "Win-Sophos-Connect-Install-2-5-0.ps1",
        $ScriptAuthor = "DAM",
        $WrittenDate = "2025-11-14",
        $ModifiedDate = "Never",
        $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor $WrittenDate, last modified $ModifiedDate."
    )
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}
#Checks to see if the terminal is running as an administrator.
function Test-TerminalElevation {
    #Checks if the terminal is running as admin/elevated as Invoke-WebRequest will not run without it.
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
        $ProgramPath = "c:\Program Files (x86)\Sophos\Connect\GUI\scgui.exe",
        #TMP install folder location.
        $TMPInstallerFolderLocation = "C:",
        #TMP install folder.
        $TempInstallFolder = "TMP-Installer-99",
        #Download Link
        $URI = 'https://download.sophos.com/network/clients/SophosConnect_2.5.0_GA_IPsec_and_SSLVPN.msi',
        #Installer Name
        $InstallerName = "SophosConnect_2.5.0_GA_IPsec_and_SSLVPN.msi",
        #Out-File location.
        $OutFile = "$TMPInstallerFolderLocation\$TempInstallFolder\$InstallerName"
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
            #Creates the TMP folder if it does not already exists.
            if (Test-Path -Path "$TMPInstallerFolderLocation\$TempInstallFolder") {
                Write-Verbose -Message "'$TMPInstallerFolderLocation\$TempInstallFolder' exists...continuing script..." -Verbose
            }else {
                Write-Verbose -Message "'$TMPInstallerFolderLocation\$TempInstallFolder' does not exists...creating temp folder..." -Verbose
                New-Item -Path "$TMPInstallerFolderLocation\$TempInstallFolder" -ItemType "Directory"
            }
        #Downloads the latest msi.
        try {
            #Disabled Invoke-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
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
            $ArgumentList = @(
            "/QN"
            )
            Start-Process -FilePath "$OutFile" -ArgumentList "$ArgumentList"
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


