    #ReadMe
<#
    
    .SYNOPSIS

        Gets all Restore Points.


    .OUTPUTS
        
        CreationTime           Description                    SequenceNumber    EventType         RestorePointType
        ------------           -----------                    --------------    ---------         ----------------
        8/31/2022 10:00:02 PM  Windows Backup                 129               BEGIN_SYSTEM_C... 15
        9/1/2022 7:17:12 AM    ACAD broke, Post ACAD fix      130               BEGIN_SYSTEM_C... 16
        9/1/2022 10:00:02 PM   Windows Backup                 131               BEGIN_SYSTEM_C... 15


    .LINK
        
        https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-computerrestorepoint?source=recommendations&view=powershell-5.1

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

