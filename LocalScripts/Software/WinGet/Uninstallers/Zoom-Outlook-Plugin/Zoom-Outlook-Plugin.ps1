    #ReadMe
<#

.DESCRIPTION
        
    Upgrade Zoom OutlookPlugin. 
    
    
.Notes

    Written for PS7.X so I dont have to install Nuget. Nuget is required for PS5.1.

.INPUTS
        
    None.


.OUTPUTS
        
System.String :

WARNING: Outlook needs to be closed...Preparing to Taskkill Outlook.exe

Confirm
Continue with this operation?
[Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend  [?] Help (default is "Y"): Y
    
Starting package uninstall...

Successfully uninstalled


.LINK
    
    [WinGet Uninstall Online Version](https://learn.microsoft.com/en-us/windows/package-manager/winget/uninstall)

    
#>

#Script


if (! ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Error "This script requires Administrator rights. To run this cmdlet, start PowerShell with the `"Run as administrator`" option."
    return
}

#Checks the PS terminal version this is ran in 7.X.X.

#https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

	
	

if ($PSVersionTable.PSVersion.Major -eq 7) {
		
	Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
} 
	
else {
		
	Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 7.X.X...Ending Script" -WarningAction Inquire
		
	Start-Sleep -Seconds 3

	Exit
}

Write-Warning "Outlook needs to be closed...Preparing to Taskkill Outlook.exe" -WarningAction Inquire

taskkill /f /im Outlook.exe

winget uninstall --id Zoom.ZoomOutlookPlugin

