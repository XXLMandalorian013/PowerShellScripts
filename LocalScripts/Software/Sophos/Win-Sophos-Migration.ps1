#ReadMe
<#
Win-Sophos-Migration.ps1
.SYNOPSIS
Migrates a device from one central tenant to another.
.Notes
Disable tamper on the device to migrate, enable migration in both tenant in each tenants general settings.
Change the URL per server or workstation installers
Sophos Installer Notes: https://docs.sophos.com/central/partner/help/en-us/Help/Configure/Installers/WindowsCommandLine/index.html#command-line-options
.INPUTS
None.
.OUTPUTS
System.String,
#>
#Script
#Region Start-Script
#Script Boiler Plate.
function Start-ScriptBoilerPlate {
    param (
        #Script Name
        $ScriptName = "Win-Sophos-Migration.ps1",
        #Script Author
        $ScriptAuthor = "Written by DAM on 2025-12-04"
    )
    #Script Introduction
    Write-Verbose -Message "$ScriptName $ScriptAuthor" -Verbose 
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
#Creates the TMP folder if it does not already exists.
function New-TMPFolder {
    param(
        #TMP install folder location.
        $TMPInstallerFolderLocation = "C:",
        #TMP install folder.
        $TempInstallFolder = "TMP-Installer-99"
    )
    #Creates the TMP folder if it does not already exists.
    if (Test-Path -Path "$TMPInstallerFolderLocation\$TempInstallFolder") {
        Write-Verbose -Message "'$TMPInstallerFolderLocation\$TempInstallFolder' exists...continuing script..." -Verbose
    }else {
        Write-Verbose -Message "'$TMPInstallerFolderLocation\$TempInstallFolder' does not exists...creating temp folder..." -Verbose
        New-Item -Path "$TMPInstallerFolderLocation\$TempInstallFolder" -ItemType "Directory"
    }
}
#Checks to see if the software is already installed, if not, it installs it.
function Install-Software {
    param(
        #TMP install folder location.
        $TMPInstallerFolderLocation = "C:",
        #TMP install folder.
        $TempInstallFolder = "TMP-Installer-99",
        #Program Path when its installed.
        $ProgramPath = "C:\Program Files\Sophos\Sophos Endpoint Agent\SophosUninstall.exe",
        #Download Link
        $URI = "https://dzr-api-amzn-us-west-2-fa88.api-upe.p.hmr.sophos.com/api/download/123456789/SophosSetup.exe",
        #Full name of the installer.
        $InstallerName = "SophosSetup.exe",
        #Out-File location.
        $OutFile = "$TMPInstallerFolderLocation\$TempInstallFolder\$InstallerName"
    )
    #Checks to see if the program is already installed.
    $TestPath = Test-Path -Path "$ProgramPath"
    if ($TestPath -match 'True') {
        Write-Verbose "$InstallerName is already installed...starting migration..." -Verbose
        #Ensures PowerShell 3.0 and higher is being used. Invoke-WebRequest is only able to run on PowerShell ver 3.0 and higher.
        if ($PSVersionTable.PSVersion.Major -ge "3") {
            Write-Verbose -Message "The PowerSHell version is grater than 3.0...Continuing script..." -Verbose
        }else {
            Throw "This scripts Invoke-WebRequest is only able to run on PowerShell ver 3.0 and higher."
        }
        #Downloads the latest exe.
        try {
            #Disabled Invoke-WebRequests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
            $ProgressPreference = 'SilentlyContinue'
            Write-Verbose -Message "Downloading $InstallerName..." -Verbose
            #TLS fix fold older server
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing
        }catch {
            Write-Verbose -Message"$Error[0]" -Verbose
            Write-Verbose -Message"$InstallerName may not match what is being download anymore?" -Verbose
        }
        #Installs the Program.
        try {
            Write-Verbose -Message "Migrating device...please wait..." -Verbose
            Start-Process -FilePath "$OutFile" -ArgumentList @(
            "--registeronly"
            "--quiet"
            )
            Start-Sleep -Seconds 10
            Write-Verbose -Message "Check the target central portal for this device..." -Verbose
            #Install check.
            try {
            }catch {
                Write-Verbose -Message "Error[0]" -Verbose
            }
        }catch {
            Write-Verbose -Message "Error[0]" -Verbose
        }
    }else {
        Throw "$InstallerName is not installed installed...exiting script..."
    }
}
#Script Boiler Plate
Start-ScriptBoilerPlate
#Checks to see if the terminal is running as an administrator.
Test-TerminalElevation
#Creates the TMP folder if it does not already exists.
New-TMPFolder
#Checks to see if the software is already installed, if not, it installs it.
Install-Software
#EndRegion

