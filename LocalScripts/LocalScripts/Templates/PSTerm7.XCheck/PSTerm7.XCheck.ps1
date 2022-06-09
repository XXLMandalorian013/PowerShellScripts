#Checks the PS terminal version this is ran in 7.X.X.

	##https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

	#Thanks to dotnVO for the help w/ this
	

	if ($PSVersionTable.PSVersion.Major -eq 7) {
		
		Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
	} else {
		
		Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 7.X.X...Ending Script" -WarningAction Inquire
		
		Exit
	}
