#ReadMe
<#

Write-ErrorLog.ps1

.SYNOPSIS

A function that captures errors in a script and outputs it to a .txt.
    
.DESCRIPTION
        
Writes-Error to the console and creates a error log .txt captureing the issue. The script will stop and exit upon getting an error. 
Write everything in a Try/Catch and or Finally CMDLet to capture the error output.    
    
.Notes

Works in 7.X.X.

.INPUTS
        
None.

.OUTPUTS

VERBOSE: $ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate
VERBOSE: Logging Compleated Step
VERBOSE: Test-ExsistingProgamPath
VERBOSE: Test-DownloadLink
VERBOSE: Logging Compleated Step
VERBOSE: Get-ProgramDownload#Starts the installer.
VERBOSE: Logging Compleated Step
VERBOSE:Start-Installer
VERBOSE: Logging Compleated Step
Remove-InstallerFolder
VERBOSE: Logging Compleated Step
VERBOSE:$ScriptName has finished successfully...Script Ending...

Write-ScriptStep function.

    Verbose.String, and .txt output of error per try catch.

    VERBOSE: Logging Compleated Step

    VERBOSE: Logging Compleated Step


Write-ErrorLog function.

    Verbose.String, and .txt output of error per try catch.

    Directory: C:\

    Mode                 LastWriteTime         Length Name
    ----                 -------------         ------ ----
    d----           3/13/2023  5:07 PM                Temp MitelConnect Installer
    Write-ErrorLog:
    Line |
    5 |      Write-ErrorLog -Text "Get-Buttz is not a know PS CMDLet."
        |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        | Script error detected...script is ending...

.LINK

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3) 
        
[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3)

[New-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.3) 

[Get-Date](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.3)

[Write-Error](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-error?view=powershell-7.3)

[Out-File](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-file?view=powershell-7.3)

[Write-Verbose](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-verbose?view=powershell-7.3)

[Add-Content](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-content?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.3)


#>

#Script-Start

#Gloabal Variables

$ScriptAuthor = "DAM"

$ModifiedDate = "2023-03-16"

$ScriptName = "Mitel-Connect-Installer.ps1"

$TempInstallerPath = "C:\"

$InstallerFolderName = 'Temp-MitelConnect-Installer'

$InstallerName = 'MitelConnect.exe'

$ProgramPath = "C:\Users\$env:UserName\AppData\Local\Programs\Mitel\Connect\Mitel.exe"

#Disabled Invove-WebReqests progress bar speeding up the download for 5.1 and fixing the bar sticking in 7.X. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
$ProgressPreference = 'SilentlyContinue'

$URI = 'https://upgrade01.sky.shoretel.com/ClientInstall/NonAdmin'

$OutFile = "$TempInstallerPath\$InstallerFolderName"

$InstallerType = "C:\Users\HUA\AppData\Local\Programs\teamwork\Mitel Teamwork.exe"


#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {

    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."  
}

#A function to log the steps of a script.
function Write-ScriptStep {
    [CmdletBinding ()]
    param (
        [string]$Text
    )

    $ExsitingStep = Test-Path -Path "$OutFile\$ScriptName-Log-File.txt"

    if ("$ExsitingStep" -eq 'False') {
        
        New-Item -Path "$TempInstallerPath" -Name "$InstallerFolderName" -ItemType 'Directory' | Out-Null -ErrorAction SilentlyContinue

        $Entry = (Get-Date -Format "yyyy/MM/dd HH:mm dddd - ") + $Text

        $Entry | Out-File -Path "$OutFile\$ScriptName-Log-File.txt"

        Write-Verbose -Message "Logging Compleated Step" -Verbose

    }else {

        Add-Content -Path "$OutFile\$ScriptName-Log-File.txt" -Value "$Text"

        Write-Verbose -Message "Logging Compleated Step" -Verbose
    }
}

#A function to stop the sctipt and create a .txt with a log file of the error.
function Write-ErrorLog {
    [CmdletBinding ()]
    param (
        [string]$Text
    )

    New-Item -Path "$TempInstallerPath" -Name "$InstallerFolderName" -ItemType 'Directory' -ErrorAction SilentlyContinue

    $Entry = (Get-Date -Format "yyyy/MM/dd HH:mm dddd - ") + $Text

    Write-Error -Message "Script error detected...script is ending..."

    $Entry | Out-File -Path "$OutFile\$ScriptName-Error-Log-File.txt"

    Start-Sleep -Seconds 5

    Exit
}

#Writes to the terminal with this script general info.
function Write-ScriptBoilerplate {
    try {

        $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate"

        Write-Verbose -Message "$ScriptBoilerplate" -Verbose

        Write-ScriptStep -Text "$ScriptBoilerplate"

    }
    catch {

        Write-ErrorLog -Text "Write-ScriptBoilerplate failed.$Error[0]"
    }  
}

#Checks to see if the program is already installed.
function Test-ExsistingProgramPath {
    Try {

        Write-Verbose -Message "Test-ExsistingProgamPath" -Verbose

        $TestPath = Test-Path -Path "$ProgramPath"

        If ($TestPath -eq 'True') {

            Write-ScriptStep -Text "$InstallerName is already installed...Ending script..."

            Write-Verbose -Message "$InstallerName is already installed...Ending script..." -Verbose

            Start-Sleep -Seconds 5

            Exit
        }
    }Catch {

        Write-ErrorLog -Text "Test-ExsistingProgramPath failed...$Error[0]"
    }
}

#Check if the download link is broken.
function Test-DownloadLink {
    Try {

        Write-Verbose -Message "Test-DownloadLink" -Verbose

        $InvokeWeb = Invoke-WebRequest -Method Head -URI "$URI" -UseBasicParsing

        If ($InvokeWeb.StatusDescription -eq "OK") {

            Write-ScriptStep -Text "Test-DownloadLink completed"
        }
    }Catch {

        Write-ErrorLog -Text "Test-ExsistingProgramPath failed...Check download link...$Error[0]"
    }
}

#Downloads the program installer with Invoke-Webrequest.
function Get-ProgramDownload {
    #Downloads Program via web.
    Try {

        Write-Verbose -Message "Get-ProgramDownload" -Verbose

        Invoke-WebRequest -URI "$URI" -OutFile "$OutFile\$InstallerName" -UseBasicParsing

        Write-ScriptStep -Text "Get-ProgramDownload completed"

    }Catch {

        Write-ErrorLog -Text "Get-ProgramDownload failed...Check download link...$Error[0]"

    }
}

#Starts the installer.
function Start-Installer {
    Try {

        Write-Verbose -Message "Start-Installer" -Verbose

        Start-Process -FilePath "$OutFile\$InstallerName" -ArgumentList "/S", "/V/qn"

        Do { 
            $InstallerRunning = Get-Process -ProcessName "$InstallerType"

            Start-Sleep -Seconds 15

            If ($InstallerRunning -eq 'True') {

                Write-Information -MessageData "$InstallerName installer is running...Please wait" -InformationAction Continue

                Start-Sleep -Seconds 5

            }
        }Until ($InstallerRunning -eq 'False')

        Write-ScriptStep -Text "Start-Installer completed"

    }Catch {

        Write-ErrorLog -Text "Start-Installer...Check installer peramiters...$Error[0]"

    } 
}

#Checks if the program installed, if so it deletes the temp folder is made.
function Remove-InstallerFolder {
    Try {

        Write-Verbose -Message "Remove-InstallerFolder" -Verbose

        Remove-Item -Path "$OutFile" -Recurse

        Write-ScriptStep -Text "Remove-InstallerFolder completed"

    }Catch {

        Write-ErrorLog -Text "Remove-InstallerFolder...Check installer peramiters...$Error[0]"

    }Finally {

        Write-ScriptStep -Text "$ScriptName has finished successfully...Script Ending..."

        Write-Verbose -Message "$ScriptName has finished successfully...Script Ending..." -Verbose

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

#Script-Stop