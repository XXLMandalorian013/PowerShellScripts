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
    $ScriptName = "VulScan-Discovery-Agent-Uninstall.ps1"
    $ScriptAuthor = "DAM"
    $ModifiedDate = "2024-02-08"
    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate"
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}
#Letting the user know what is starting.
Start-ScriptBoilerplate
#EndRegion