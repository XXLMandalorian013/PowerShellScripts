<#

OneDrive-Install.ps1.ps1

.SYNOPSIS

Installs OneDrive 64-Bit Machine wide.

.Notes

An elevated terminal and PS Ver 3.0 or higher is required.

#>

#Script
#Region Start-Script
#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    param (
        $ScriptName = "OneDrive-Install.ps1",
        $ScriptAuthor = "DAM",
        $WrittenDate = "2024-12-13",
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
    } else {
        Write-Verbose -Message "The terminal is running as an Administrator...Continuing script..." -Verbose
    }
}
#Checks to see if the software is already installed, if not, it installs it.
function Install-Software {
    param (
        #Program Paths to check.
        $ProgramPaths = @(
            "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk",
            "C:\Program Files\Microsoft OneDrive",
            "C:\Users\$env:UserName\AppData\Local\Microsoft\OneDrive"
        ),
        #Download Link
        $URI = 'https://go.microsoft.com/fwlink/p/?LinkID=2182910&clcid=0x409&culture=en-us&country=us',
        #Full name of the installer.
        $InstallerName = 'OneDriveSetup.exe',
        #Out-File location.
        $OutFile = "C:\$InstallerName"
    )
    #Checks to see if the program is already installed.
    $OneDriveInstalled = $false
    foreach ($path in $ProgramPaths) {
        if (Test-Path $path) {
            Write-Verbose -Message "$path exists." -Verbose
            $OneDriveInstalled = $true
        } else {
            Write-Verbose -Message "$path does not exist." -Verbose
        }
    }
    if ($OneDriveInstalled) {
        Throw "$InstallerName is already installed..."
    } else {
        #Ensures PowerShell 3.0 and higher is being used. Invoke-WebRequest is only able to run on PowerShell ver 3.0 and higher.
        if ($PSVersionTable.PSVersion.Major -ge "3") {
            Write-Verbose -Message "The PowerShell version is greater than 3.0...Continuing script..." -Verbose
        } else {
            Throw "This script's Invoke-WebRequest is only able to run on PowerShell ver 3.0 and higher."
        }
        #Downloads the latest exe.
        try {
            #Disabled Invoke-WebRequest's progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
            $ProgressPreference = 'SilentlyContinue'
            Write-Verbose -Message "Downloading $InstallerName..." -Verbose
            Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing
        } catch {
            Write-Verbose -Message "$Error[0]" -Verbose
            Write-Verbose -Message "$InstallerName may not match what is being downloaded anymore?" -Verbose
        }
        #Installs the Program.
        try {
            Write-Verbose -Message "Installing $InstallerName" -Verbose
            Start-Process -FilePath "$OutFile" -ArgumentList "/quiet"
            Start-Sleep -Seconds 10
            #Install check.
            try {
                do {
                    $OneDriveInstalled = $false
                    foreach ($path in $ProgramPaths) {
                        if (Test-Path $path) {
                            $OneDriveInstalled = $true
                            break
                        }
                    }
                    if (-not $OneDriveInstalled) {
                        Write-Verbose -Message "$InstallerName installer is running...Please wait" -Verbose
                        Start-Sleep -Seconds 8
                    }
                } until ($OneDriveInstalled)
                Start-Sleep -Seconds 8
                Write-Verbose -Message "$InstallerName Installed!" -Verbose
                Remove-Item -Path "$OutFile"
            } catch {
                Write-Verbose -Message "$Error[0]" -Verbose
            }
        } catch {
            Write-Verbose -Message "$Error[0]" -Verbose
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