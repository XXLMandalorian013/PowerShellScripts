    #ReadMe
<#

.DESCRIPTION
        
    Installs PS 7.X.X. 
    
    
.Notes

    Written for Windows PS 5.1 as of 1-5-22 PS7 does not come preinstalled on new Win 10 + Machines.

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


winget install --id Microsoft.PowerShell


