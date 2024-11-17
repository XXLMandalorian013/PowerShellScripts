# Download latest msi to install DA

Invoke-WebRequest -Uri 'https://download.rapidfiretools.com/download/DiscoveryAgent.msi' -OutFile 'C:\DA_install\DiscoveryAgent.msi'




$arguments = "/i C:\DA_install\DiscoveryAgent.msi /quiet"

Start-Process msiexec.exe -ArgumentList $arguments -Wait




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

        $ScriptName = 'Win-VulScan-Discov-Uninstall.ps1',

        #Script Author

        $ScriptAuthor = 'Written by DAM on 2024-06-10'

    )

    #Script Introduction

    Write-Verbose -Message "$ScriptName $ScriptAuthor" -Verbose 

}

#Reinstall-Repair of Discovery Agent

function Repair-DiscoveryAgent {

    Invoke-WebRequest -Uri 'https://download.rapidfiretools.com/download/DiscoveryAgent.msi' -OutFile 'C:\DiscoveryAgent.msi' -UseBasicParsing

    Set-Location -Path "C:/"

    $arguments = "/i C:\DiscoveryAgent.msi /quiet"

    Start-Process msiexec.exe -ArgumentList $arguments -Wait

    Remove-Item -Path 'C:\DiscoveryAgent.msi' -Force

}

#Uninstalls the Program from URI.

function Uninstall-DiscoveryAgent {

    param(

        #Program Path when its installed.

        $ProgramPath = 'C:\Program Files (x86)\DiscoveryAgent\Agent\bin\DiscoveryAgent.exe',

        #Download Link

        $URI = 'https://download.rapidfiretools.com/download/DiscoveryAgent.msi',

        #Full name of the installer.

        $UninstallerName = 'DiscoveryAgent.msi',

        #Out-File location.

        $OutFile = "C:\$UninstallerName",

        $ProcessName = "Discorvery Agent"

    )

    $ExsistingInsatll = Test-Path -Path "$ProgramPath"

    if ($ExsistingInsatll -match 'False') {

        Write-Verbose -Message "$UninstallerName is already uninstalled...$ProgramPath" -Verbose

    }

    else {

        #Downloads the latest msi.

        try {

            #Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138

            $ProgressPreference = 'SilentlyContinue'

            Write-Verbose -Message "Downloading .exe installer for $UninstallerName..." -Verbose

            Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing

        }catch {

            Write-Verbose -Message"$Error[0]" -Verbose

            Write-Verbose -Message"$UninstallerName may not match what is being download anymore?" -Verbose

            Write-Verbose -Message"Invoke-WebRequest is not supported on Win 7..." -Verbose

        }

        #Installs the Program from URI.

        try {

            Write-Verbose -Message "Installing $UninstallerName" -Verbose

            #Stops any of the programs services from running to uninstall it.

            taskkill /f /im $ProcessName

            Set-Location -Path "C:/"

            msiexec /x "$OutFile" /quiet

            #Ininstall check and TEMP file delete.

            try {

                do { 

                    $TestPath = Test-Path -Path "$ProgramPath"

                    if ($TestPath -match 'True') {

                        Write-Verbose -Message "$UninstallerName uninstaller is running...Please wait" -Verbose

                        Start-Sleep -Seconds 5

                    }

                }Until ($TestPath -ne 'True')

                    Write-Verbose -Message "$UninstallerName uninstalled!" -Verbose

                    Start-Sleep -Seconds 5

                    Write-Verbose -Message "$UninstallerName removed" -Verbose

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

#Reinstall-Repair of Discovery Agent

Repair-DiscoveryAgent

#Installs the Program from URI.

Uninstall-DiscoveryAgent