

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
        $ScriptName = 'Cloud-Contact-Center-ZAC-Installer.ps1',
        #Script Author
        $ScriptAuthor = 'Written by DAM on 2025-08-12'
    )
    #Script Introduction
    Write-Verbose -Message "$ScriptName $ScriptAuthor" -Verbose 
}
#Installs Accent's Cloud Contact Center ZAC
function Install-CCCZac {
    param(
        #Program Path when its installed.
        $ProgramPath = 'C:\Program Files (x86)\Zultys\ZAC',
        #Download Link
        $URI = 'https://mirror.zultys.biz/ZAC/ZAC_x64-9.4.11.exe',
        #Full name of the installer.
        $InstallerName = 'ZAC_x64-9.4.11.exe',
        #Out-File location.
        $OutFile = "C:\$InstallerName"
    )
    $ExsistingInsatll = Test-Path -Path "$ProgramPath"
    if ($ExsistingInsatll -match 'True') {
        Write-Verbose -Message "$InstallerName is already installed...$ProgramPath" -Verbose
    }
    else {
        #Downloads the latest msi.
        try {
            #Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
            $ProgressPreference = 'SilentlyContinue'
            Write-Verbose -Message "Downloading .exe installer for $InstallerName..." -Verbose
            Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing
        }catch {
            Write-Verbose -Message"$Error[0]" -Verbose
            Write-Verbose -Message"$InstallerName may not match what is being download anymore?" -Verbose
            Write-Verbose -Message"Invoke-WebRequest is not supported on Win 7..." -Verbose
        }
        #Installs the Program from URI.
        try {
            Write-Verbose -Message "Installing $InstallerName" -Verbose
            $InstallerPath = "$OutFile"
            $Arguments = "/S /v/qn"
            Start-Process -FilePath $InstallerPath -ArgumentList $Arguments
        }catch {
            Write-Verbose -Message "$Error[0]" -Verbose
        }
        #Ininstall check and TEMP file delete.
        try {
            do { 
                $TestPath = Test-Path -Path "$ProgramPath"
                if ($TestPath -ne 'True') {
                    Write-Verbose -Message "$InstallerName installer is running...Please wait" -Verbose
                    Start-Sleep -Seconds 10
                }
            }Until ($TestPath -eq 'True')
                Write-Verbose -Message "$InstallerName installed!" -Verbose
                Start-Sleep -Seconds 15
                Write-Verbose -Message "$InstallerName removed" -Verbose
                Remove-Item "$OutFile"
        }catch {
            Write-Verbose -Message "$Error[0]" -Verbose
        }
    }
}

Start-ScriptBoilerPlate

Install-CCCZac

