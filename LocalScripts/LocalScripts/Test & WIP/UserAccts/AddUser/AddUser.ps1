#Add a user to a PC

#Checks to see if the code is being ran "As Admin".
		Write-Host "Checking for elevated permissions..."
		if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
		[Security.Principal.WindowsBuiltInRole] "Administrator")) {
		Write-Warning "This Terminal is not running as Admin, open a Terminal console as an administrator and run this script again."
		Break
		}
		else {
		Write-Host "The Terminal is running in a administrator...Running Code" -ForegroundColor Green
		}  


#Checks the PS terminal version this is ran in 5.X.X.

	#https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

	#Thanks to dotnVO for the help w/ this
	

	if ($PSVersionTable.PSVersion.Major -eq 5) {
		
		Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
	} else {
		
		Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 5.X.X...Ending Script" -WarningAction Inquire
		
		Exit
	}

#Add a user to a PC

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.localaccounts/new-localuser?view=powershell-5.1&viewFallbackFrom=powershell-7.2

		$UserName = Read-Host 'Enter user name'

		$Password = Read-Host 'Please enter users password' -AsSecureString

		New-LocalUser -Name 'Admin' -AccountNeverExpires -Password $Password -PasswordNeverExpires 

