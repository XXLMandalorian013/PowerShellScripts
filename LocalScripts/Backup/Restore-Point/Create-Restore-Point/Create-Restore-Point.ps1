    #ReadMe
<#
    
    .SYNOPSIS

        Creates a Restore Point.


    .DESCRIPTION

        Prompts for a description of the restore pooint and then creates a Restore Point.


    .OUTPUTS
    
        1.

        WARNING: A new system restore point cannot be created because one has already been created within the past 1440
        minutes. The frequency of restore point creation can be changed by creating the DWORD value
        'SystemRestorePointCreationFrequency' under the registry key 'HKLM\Software\Microsoft\Windows
        NT\CurrentVersion\SystemRestore'. The value of this registry key indicates the necessary time interval (in minutes)
        between two restore point creation. The default value is 1440 minutes (24 hours).


    .EXAMPLE
        
        PS> extension "File" "doc"
        File.doc


    .LINK
        
        Online version: http://www.fabrikam.com/extension.html

#>

#Script

#Checks the PS terminal version this is ran in 5.X.X.

	##https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

	#Thanks to dotnVO for the help w/ this
	

if ($PSVersionTable.PSVersion.Major -eq 5) {
		
	Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
} else {
		
	Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 5.X.X...Ending Script" -WarningAction Inquire
		
	Start-Sleep -Seconds 3

	Exit

	}

$Description = Read-Host "Please type what you wish to call this Restore Point..."

Checkpoint-Computer -Description "$Description"  