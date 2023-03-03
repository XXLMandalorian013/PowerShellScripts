    #ReadMe
<#

Title
    
.SYNOPSIS

Adds a file name extension to a supplied name.


.DESCRIPTION
        
Adds a file name extension to a supplied name.  
    
    
.Notes

Notes here.
    

.PARAMETER Name
        
Specifies the file name.

    
.PARAMETER Extension
        
Specifies the extension. "Txt" is the default.


.INPUTS
        
None. You cannot pipe objects to Add-Extension.


.OUTPUTS
        
System.String. Add-Extension returns a string with the extension or file name.


.EXAMPLE
        
PS> extension "File" "doc"
File.doc


.LINK
        
[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3) 

#>

#Script

#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
        
}

#Gloabal Variables

$ExsistingProgramPath = "C:\Users\$env:UserName\AppData\Local\Programs\Mitel\Connect\Mitel.exe"

$TempInstallerPath = "C:\"

$InstallerFolderName = 'Temp MitelConnect Installer'

$LogFileFolderName = "$InstallerFolderName-LogFile"

$InstallerName = 'MitelConnect.exe'

$OutFile = "$TempInstallerPath\$InstallerFolderName"

#Writes to the terminal with this script general info.
function Write-ScriptBoilerplate {
    $ScriptName = "Get-Specific-Running-Task.ps1"

    $ScriptAuthor = "DAM"

    $ModifiedDate = "2023-03-02"

    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate"
    
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}

#Creates a Dir for this scripts installer.
function New-InstallerFolder {
    Try {
        Write-Verbose -Message "New-InstallerFolder" -Verbose

        New-Item -Path "$TempInstallerPath" -Name "$InstallerFolderName" -ItemType 'Directory' -ErrorAction STOP
    }Catch {
        Write-Error -Message $_
    }  
}

#Creates a log folder for this script
function New-LogFolder {
    Try {
        Write-Verbose -Message "New-LogFolder" -Verbose

        New-Item -Path "$TempInstallerPath\$InstallerFolderName" -Name $LogFileFolderName -ItemType 'Directory' -ErrorAction STOP
    }Catch {
        Write-Error -Message $_ 
    }
}

#Checks to see if the program is already installed.
function Test-ExsistingProgamPath {
    Try {
        Write-Verbose -Message "Test-ExsistingProgamPath" -Verbose
        
        $TestPath = Test-Path -Path "$ExsistingProgramPath" -ErrorAction STOP

        If ($TestPath -eq 'True') {

            Throw "$InstallerName is already installed..."
        }
    }Catch {
        Write-Error -Message $_
    }
}

#Check if the download link is broken.
function Test-DownloadLink {
    Try {
        Write-Verbose -Message "Test-DownloadLink" -Verbose

        $URI = 'https://upgrade01.sky.shoretel.com/ClientInstall/NonAdmin'

        $InvokeWeb = Invoke-WebRequest -Method Head -URI "$URI" -UseBasicParsing -ErrorAction STOP
    
        If ($InvokeWeb.StatusDescription -eq "OK") {
        }
    }Catch {
        Write-Error -Message $_
    }
}

#Downloads the program installer with Invoke-Webrequest.
function Get-ProgramDownload {
    #Downloads Program via web.

    Try {
        Write-Verbose -Message "Get-ProgramDownload" -Verbose

        Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing -ErrorAction STOP
    }Catch {
        Write-Error -Message $_
    }
}

#Starts the installer.
function Start-Installer {
    Try {
        Write-Verbose -Message "Start-Installer" -Verbose

        Start-Process -FilePath "$OutFile" -ArgumentList "/S", "/V/qn" -ErrorAction STOP
        Do { 
            $TestPath = Test-Path -Path "$ProgramPath"
            If ($TestPath -ne 'True') {
                Write-Host "$InstallerName installer is running...Please wait"
                
                Start-Sleep -Seconds 5
            }
        } 
        Until ($TestPath -eq 'True')
    }Catch {
        Write-Error -Message $_
    } 
}

function Remove-InstallerFolder {
    Try {
        Write-Verbose "$InstallerName installed!" -Verbose

        Start-Sleep -Seconds 5
    
        Remove-Item "$OutFile"
    }
    Catch {
        Write-Error -Message $_
    }
    
    
}

#Writes to the terminal with this script general info.
Write-ScriptBoilerplate

#Runs the New-InstallerFolder Function.
New-InstallerFolder

#Creates a log folder for this script.
New-LogFolder

#Check if the download link is broken.
Test-DownloadLink

#Downloads the program installer with Invoke-Webrequest.
Get-ProgramDownload

#Starts the installer.
Start-Installer

#Creates a log file entry if an error occurs.
function Write-LogFileEntry {

    Try {
        $Date = Get-Date -Format "dddd MM/dd/yyyy HH:mm K"

        New-Item -Path "$TempInstallerPath\$InstallerFolderName\$LogFileFolderName" -Name "$Date-ScriptError.txt" -ItemType 'File' -Value "$Error" -ErrorAction STOP
    }
    Catch {
        Write-Error -Message $_ 
    }
}




#Ininstall check and TEMP file delete.
Try {
    Do { 
        $TestPath = Test-Path -Path "$ProgramPath"
        If ($TestPath -ne 'True') {
            Write-Host "$InstallerName installer is running...Please wait"
            
            Start-Sleep -Seconds 5
    
        }
    } 
    Until ($TestPath -eq 'True')
}Catch {
    Throw $Error[1]
}Finally {
    Start-Sleep -Seconds 8

    
}



