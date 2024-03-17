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

[WinGet Install Online Version](https://learn.microsoft.com/en-us/windows/package-manager/winget/install) 

#>

#Region Start-Script
#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    param (
        $ScriptName = "Power-Toys-.79-64Bit-Machine.ps1",
        $ScriptAuthor = "DAM",
        $WrittenDate = "2024-03-17",
        $ModifiedDate = "Never",
        $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor $WrittenDate, last modified $ModifiedDate"
    )
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}
#Checks to see if the terminal is running as an administrator.
function Test-TerminalElevation {
    #Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
    }else {
        Write-Verbose -Message "The terminal is running as an Administrator...Continuing script..." -Verbose
    }
}
#Letting the user know what is starting.
Start-ScriptBoilerplate
#Checks to see if the terminal is running as an administrator.
Test-TerminalElevation
#EndRegion