    #ReadMe
<#

.DESCRIPTION
        
    Uninstalls PS 7.X.X. 
    
    
.Notes

    Written for Windows PS 5.1 as uninstalling PS 7.X.X can't be done via PS 7.X.X.

.INPUTS
        
    None.


.OUTPUTS
        
System.String :
    
Successfully verified installer hash

Starting package install...

Successfully installed.


.LINK
        
    https://learn.microsoft.com/en-us/windows/package-manager/winget/install

#>

#Script


if (! ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Error "This script requires Administrator rights. To run this cmdlet, start PowerShell with the `"Run as administrator`" option."
    return
}


#Checks the PS terminal version this is ran in 5.1.

#https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

	
	

if ($PSVersionTable.PSVersion.Major -eq 5) {
		
	Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
} 
	
else {
		
	Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in Windows PowerShell Version 5.1...Ending Script" -WarningAction Inquire
		
	Start-Sleep -Seconds 3

	Exit
}


winget uninstall --id Microsoft.PowerShell


