    #ReadMe
<#

.DESCRIPTION
        
    Uninstalls OneDrive silently. 
    
    
.Notes

    Written for PS7.X so I dont have to install Nuget. Nuget is required for PS5.1.

.INPUTS
        
    None.


.OUTPUTS
        
System.String :
    
Starting package uninstall...

Successfully uninstalled


.LINK
    [WinGet Uninstall Online Version](https://learn.microsoft.com/en-us/windows/package-manager/winget/uninstall)   
   

#>

#Script


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


winget uninstall --id Microsoft.OneDrive