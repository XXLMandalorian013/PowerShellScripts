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


#Checks the PS terminal version this is ran in.

	##https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

	

	if(Get-InstalledModule -Name "BurntToast".version -MinimumVersion 0.8.5 -ErrorAction Ignore)
	{

	Write-Host "BurntToast 0.8.5 is installed...Ending Script"

	Start-Sleep -Seconds -4

	Exit

	}
	

	if ($PSVersionTable.PSVersion.Major -eq 7) {
		
		#Thanks to dotnVO for the help w/ this

		#Detects if PS Module is installed and installs it if not.
	
			#https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

    		#https://docs.microsoft.com/en-us/powershell/module/powershellget/get-installedmodule?view=powershell-7.2

    		#https://docs.microsoft.com/en-us/powershell/module/powershellget/install-module?view=powershell-7.2
	}
			if(Get-InstalledModule -Name "BurntToast" -MinimumVersion 0.8.5 -ErrorAction Ignore)
			{

			Write-Host "BurntToast 0.8.5 is installed"

			}

			else

			{

			Write-Host "Installing BurntToast 0.8.5..."

			Install-Module -Name "BurntToast" -MinimumVersion 0.8.5 -Force

			Get-InstalledModule -Name "BurntToast"

			}
	
	else {
		
		#Nuget 2.8.5.201 or newer is required to install burnt toast if running PS Core or older.
	
			#https://docs.microsoft.com/en-us/powershell/module/packagemanagement/install-packageprovider?view=powershell-7.2 

				Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

				Install-Module -Name "BurntToast" -MinimumVersion 0.8.5 -Force

				Get-InstalledModule -Name "BurntToast"

	}







	

#Nuget 2.8.5.201 or newer is required to install burnt toast if running PS Core or older.
	
	#https://docs.microsoft.com/en-us/powershell/module/packagemanagement/install-packageprovider?view=powershell-7.2 

	Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force






#Detects if PS Module is installed and installs it if not.
	
	#https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

    #https://docs.microsoft.com/en-us/powershell/module/powershellget/get-installedmodule?view=powershell-7.2

    #https://docs.microsoft.com/en-us/powershell/module/powershellget/install-module?view=powershell-7.2

	if(Get-InstalledModule -Name "BurntToast" -MinimumVersion 0.8.5 -ErrorAction Ignore)
	{

	Write-Host "BurntToast 0.8.5 is installed"

	}

	else

	{

	Write-Host "Installing BurntToast 0.8.5..."

	Start-Sleep -seconds 2

	Install-Module -Name "BurntToast" -MinimumVersion 0.8.5 -Force

	Get-InstalledModule -Name "BurntToast"

	}