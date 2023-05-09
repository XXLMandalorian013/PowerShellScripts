
<# ReadMe

ESET Endpoint Security installer
    
.SYNOPSIS

Downloads and installs ESET Endpoint Security installer if not already installed.


.Notes

This ESET Installer uses the link created in the ESET Cloud Protect SAS. ESET's installers expire, so a new installer may need made and relinked below.
  

.INPUTS
        
None.


.OUTPUTS
        
System.String,

ESET Endpoint Security installer script starting...Written by DAM on 2023-02-01
epi_win_live_installer.exe install script starting...Written by DAM on 2023-01-18
Checking download link...
Download link good!
Downloading .exe installer for epi_win_live_installer.exe...
Installing epi_win_live_installer.exe
epi_win_live_installer.exe installer is running...Please wait
epi_win_live_installer.exe installed!

.LINK

[about_Scopes](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes?view=powershell-7.3)

[FireFox Silent Install](https://support.mozilla.org/en-US/kb/deploy-firefox-msi-installers#w_msiexec-options)

#>

#Region Start-Script

#Global Variables

$global:ScriptAuthor = "DAM"

$global:ModifiedDate = "2023-05-03"

$global:ScriptName = "FireFox-Installer.ps1"

$global:TempInstallerPath = "C:\"

$global:InstallerFolderName = 'Temp-Firefox-Installer'

$global:InstallerName = 'Firefox Installer.exe'

$global:ProgramPath = "C:\Program Files\Mozilla Firefox\firefox.exe"

#Disabled Invove-WebReqests progress bar speeding up the download for 5.1 and fixing the bar sticking in 7.X. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
$global:ProgressPreference = 'SilentlyContinue'

$global:URI = 'https://download.mozilla.org/?product=firefox-stub&os=win&lang=en-US'

$global:OutFile = "$global:TempInstallerPath\$global:InstallerFolderName"

$global:InstallerFinishEvent = "C:\Program Files\Mozilla Firefox\firefox.exe"


#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
if(-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {

    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."  
}

#A function to log the steps of a script.
function Write-ScriptStep {
    [CmdletBinding ()]
    param (
        [string]$Text
    )

    $ExsitingStep = Test-Path -Path "$global:OutFile\$global:ScriptName-Log-File.txt"

    if("$ExsitingStep" -eq 'False') {
        
        New-Item -Path "$global:TempInstallerPath" -Name "$global:InstallerFolderName" -ItemType 'Directory' | Out-Null -ErrorAction SilentlyContinue

        $Entry = (Get-Date -Format "yyyy/MM/dd HH:mm dddd - ") + $Text

        $Entry | Out-File -Path "$OutFile\$global:ScriptName-Log-File.txt"

        Write-Verbose -Message "Logging Compleated Step" -Verbose

    }else {

        Add-Content -Path "$OutFile\$global:ScriptName-Log-File.txt" -Value "$Text"

        Write-Verbose -Message "Logging Compleated Step" -Verbose 
    }
}

#Writes to the terminal with this script general info.
function Write-ScriptBoilerplate {
    try{

        $ScriptBoilerplate = "$global:ScriptName script starting...written by $global:ScriptAuthor, last modified on $global:ModifiedDate"

        Write-Verbose -Message "$ScriptBoilerplate" -Verbose

        Write-ScriptStep -Text "$ScriptBoilerplate"

    }catch {

    }  
}

#Checks to see if the program is already installed.
function Test-ExsistingProgramPath {
    Try{

        Write-Verbose -Message "Test-ExsistingProgamPath" -Verbose

        $TestPath = Test-Path -Path "$global:ProgramPath" -ErrorAction Stop

        If($TestPath -eq 'True') {

            Write-ScriptStep -Text "$global:InstallerName is already installed...Ending script..."

            Write-Verbose -Message "$global:InstallerName is already installed...Ending script..." -Verbose

            Write-ScriptStep -Text "Remove-InstallerFolder completed"

            Write-Verbose -Message "Remove-InstallerFolder" -Verbose

            Remove-Item -Path "$global:TempInstallerPath\$global:InstallerFolderName" -Recurse -Force -ErrorAction STOP

            Start-Sleep -Seconds 5

            Exit
        }else {
            Write-Verbose -Message "$global:InstallerName not installed...Continuing script" -Verbose

            Write-ScriptStep -Text "$global:InstallerName not installed...Continuing script"
        }
    }Catch {

    }
}

#Check if the download link is broken.
function Test-DownloadLink {
    Try{

        Write-Verbose -Message "Test-DownloadLink" -Verbose

        $InvokeWeb = Invoke-WebRequest -Method Head -URI "$global:URI" -UseBasicParsing -ErrorAction Stop

        If($InvokeWeb.StatusDescription -eq "OK") {

            Write-ScriptStep -Text "Test-DownloadLink completed"
        }
    }Catch {

    }
}

#Downloads the program installer with Invoke-Webrequest.
function Get-ProgramDownload {
    #Downloads Program via web.
    Try{

        Write-Verbose -Message "Get-ProgramDownload" -Verbose

        Invoke-WebRequest -URI "$global:URI" -OutFile "$OutFile\$global:InstallerName" -UseBasicParsing -ErrorAction Stop

        Write-ScriptStep -Text "Get-ProgramDownload completed"

    }Catch {

    }
}

#Starts the installer.
function Start-Installer {
    Try{

        Write-Verbose -Message "Start-Installer" -Verbose

        Start-Process -FilePath "$OutFile\$global:InstallerName" -ArgumentList "/q" -ErrorAction Stop

        Do{

            $InstallerFinished = Test-Path -Path "$global:InstallerFinishEvent"

            If($InstallerFinished -ne 'True') {

                Write-Information -MessageData "$global:InstallerName installer is running...Please wait" -InformationAction Continue

                Start-Sleep -Seconds 15

            }
        }Until ($InstallerFinished -eq 'True')

        Write-ScriptStep -Text "Start-Installer completed"

        Start-Sleep -Seconds 15

    }Catch {

    } 
}

#Checks if the program installed, if so it deletes the temp folder is made.
function Remove-InstallerFolder {
    Try {

        Write-Verbose -Message "Remove-InstallerFolder" -Verbose

        Remove-Item -Path "$global:TempInstallerPath\$global:InstallerFolderName" -Recurse -Force -ErrorAction STOP

        Write-ScriptStep -Text "Remove-InstallerFolder completed"

    }Catch {

    }Finally {

        Remove-Item -Path "$OutFile" -Recurse -Force -ErrorAction STOP

        Write-ScriptStep -Text "$global:ScriptName has finished successfully...Script Ending..."

        Write-Verbose -Message "$global:ScriptName has finished successfully...Script Ending..." -Verbose

        Start-Sleep -Seconds 5

        Exit
    }
}

#Writes to the terminal with this script general info.
Write-ScriptBoilerplate

#Checks to see if the program is already installed.
Test-ExsistingProgramPath

#Check if the download link is broken.
Test-DownloadLink

#Downloads the program installer with Invoke-Webrequest.
Get-ProgramDownload

#Starts the installer.
Start-Installer

#Checks if the program installed, if so it deletes the temp folder is made.
Remove-InstallerFolder

#EndRegion


