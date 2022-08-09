#Connect to Azure AD. 

#Note: Azure AD does not work in PS 7.X yet.


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
    

#Checks the PS terminal version this is ran in 7.X.X.

	#https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

        #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/import-module?view=powershell-7.2

        #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_windows_powershell_compatibility?view=powershell-7.2



	    #Thanks to dotnVO for the help w/ this!
	

	        if ($PSVersionTable.PSVersion.Major -eq 7) {
		
		        Write-Host "This script is running in $($PSVersionTable.PSVersion)."

                        Import-Module -Name AzureAD -UseWindowsPowerShell

                        Connect-AzureAD
	
	        } else {
	
                        Write-Host "This script is running in PS V 5.1 or earlier"

                        Connect-AzureAD
	
	        }


