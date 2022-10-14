    #ReadMe
<#
    
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
        
        Online version: http://www.fabrikam.com/extension.html

#>

#Script

#To access "C:\Program Files\PowerShell\7\InstallPSCorePolicyDefinitions.ps1" the terminal needs elevated.

if (! ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Error "This script requires Administrator rights. To run this cmdlet, start PowerShell with the `"Run as administrator`" option."
    return
}

#The InstallPSCorePolicyDefinitions.ps1 is located in "C:\Program Files\PowerShell\7" by defult when PS 7.X is installed. It will then create the "PowerShell Core" folder in GPO.

Set-Location -Path "C:\Program Files\PowerShell\7"

.\InstallPSCorePolicyDefinitions.ps1


#Folder Creation for PS Transcripts
  