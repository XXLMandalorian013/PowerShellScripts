    #ReadMe
<#
    
    .SYNOPSIS

        Creates a Restore Point.


    .DESCRIPTION

        Prompts for a description of the restore pooint and then creates a Restore Point.

    .Notes

        1. CMDlet does not work in 7.X.X. 
        
        2. A (Win7) File backup creates a restore point in tandeum so you may see,

        WARNING: A new system restore point cannot be created because one has already been created within the past 1440
        minutes. The frequency of restore point creation can be changed by creating the DWORD valuel
        'SystemRestorePointCreationFrequency' under the registry key 'HKLM\Software\Microsoft\Windows
        NT\CurrentVersion\SystemRestore'. The value of this registry key indicates the necessary time interval (in minutes)
        between two restore point creation. The default value is 1440 minutes (24 hours).
    
    .INPUTS

        None
        You cannot pipe objects to `Checkpoint-Computer`.

    .OUTPUTS
        
        None
        This cmdlet does not generate any output.
        


    .EXAMPLE
        
        Checkpoint-Computer -Description "Install MyApp"

        This command creates a system restore point called Install MyApp. It uses the default
        APPLICATION_INSTALL restore point type.


    .LINK
        
        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/checkpoint-computer?view=powershell-5.1

        https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

#>

#Script

#Checks the PS terminal version this is ran in 5.X.X.

#Thanks to dotnVO for the help w/ this
	

if ($PSVersionTable.PSVersion.Major -eq 5) {
		
	Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
} else {
		
	Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 5.X.X...Ending Script" -WarningAction Inquire
		
	Start-Sleep -Seconds 3

	Exit

	}

#RestorePoints by default can only be made once a day, to be able to make several restore any number of RP you need to make the fallowing Reg change.
    
if (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' -Name 'SystemRestorePointCreationFrequency' -ErrorAction SilentlyContinue) {
		
    Write-Host "Reg Key exsists...running backup"
        
}else {
            
    New-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' -Name 'SystemRestorePointCreationFrequency' -Value '0' -Type 'DWORD'
    
}

Checkpoint-Computer -Description "Automated Sys Image"

