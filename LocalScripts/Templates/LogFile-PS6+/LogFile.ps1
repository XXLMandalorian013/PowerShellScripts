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

$InstallerPath = "C:\"

$InstallerFolderName = '_Temp MitelConnect Installer'

#Writes to the terminal with this script info and author.
function Write-ScriptBoilerplate {
    $ScriptName = "Get-Specific-Running-Task.ps1"

    $ScriptAuthor = "DAM"

    $ModifiedDate = "2023-03-02"

    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate"
    
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}

#Checks to see if the program is already installed.
function Test-ExsistingProgamPath {
    Try {

        $TestPath = Test-Path -Path "$ExsistingProgramPath" -ErrorAction STOP

        if ($TestPath -eq 'True') {

            Throw "$InstallerName is already installed..."
        }
    }Catch {
        Write-Error -Message $_
    }
}

#Creates a Dir for this scripts installer.
function New-InstallerFolder {
    try {
        New-Item -Path "$InstallerPath" -Name "$InstallerFolderName" -ItemType 'Directory' -ErrorAction STOP
    }catch {
        Write-Error -Message $_
    }   
}

#Creates a log folder for this script
function New-LogFolder {
    try {
        $LogFolder = New-Item -Path "$InstallerPath\$InstallerFolderName" -Name "$InstallerFolderNamee-LogFile" -ItemType 'Directory' -ErrorAction STOP

        $LogFolder
    }catch {
        Write-Error -Message $_ 
    }
}

#Writes to the terminal with this script info and author.
Start-ScriptBoilerplate

#Checks to see if the program is already installed.
Test-ExsistingProgamPath

#Creates a Dir for this scripts installer.
New-InstallerFolder

#Creates a log folder for this script
New-LogFolder



$LogFolder = 

function Write-LogEntry {

    $Entry = (Get-Date).TOString('MM/DD/YYYY HH:mm:ss - ')

    $Entry | Out-File -FilePath $LogFolder
    
    Write-Verbose -Message $Entry -Verbose
}

