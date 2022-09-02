    #ReadMe
<#
    
    .SYNOPSIS

        Adds a file name extension to a supplied name.


    .DESCRIPTION
        Adds a file name extension to a supplied name.
        Takes any strings for the file name or extension.
    

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
        
        #https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

#>

#Script

#Checks the PS terminal version this is ran in 5.X.X.

#https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

#Thanks to dotnVO for the help w/ this
	

if ($PSVersionTable.PSVersion.Major -eq 5) {
		
Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
} else {
		
Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 5.X.X...Ending Script" -WarningAction Inquire
		
Start-Sleep -Seconds 3

Exit

}

Get-ComputerRestorePoint

