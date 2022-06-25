#Checks to see if the code is being ran "As Admin".

    #https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

    Write-Host "Checking for elevated permissions..."
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This Terminal is not running as Admin, open a Terminal console as an administrator and run this script again."
    Break
    }
    else {
    Write-Host "The Terminal is running in a administrator...Running Code" -ForegroundColor Green
    } 


#This script installs the BurntToast Module. If ran in PS V 7.X this script just installs BurntToast.
#When running this script via PS V 5.X, BurntToast requires Nuget and is installed.

	#https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2


		if(Get-InstalledModule -Name "BurntToast" -MinimumVersion 0.8.5 -ErrorAction Ignore){
   
   			Write-Host "BurntToast 0.8.5 is installed...Ending Script"
    
     			Start-Sleep -Seconds 4

    			Exit



		} elseif ($PSVersionTable.PSVersion.Major -eq 7) {

    			write-host "This script is running in $($PSVersionTable.PSVersion)."

   			Start-Sleep -Seconds 2

			Write-Host "Installing BurntToast 0.8.5..."

			Start-Sleep -Seconds 2

			Install-Module -Name "BurntToast" -MinimumVersion 0.8.5 -Force

			Get-InstalledModule -Name "BurntToast"



		} elseif ($PSVersionTable.PSVersion.Major -eq 5) {

    			Write-Host "This script is running in PowerShell $($PSVersionTable.PSVersion)."

   			Start-Sleep -Seconds 2

    			Write-Host "Installing Nuget 2.8.5.201..."

    			Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

   			Start-Sleep -Seconds 2

    			Write-Host "NuGet has been installed..."

    			Start-Sleep -Seconds 2

			Install-Module -Name "BurntToast" -MinimumVersion 0.8.5 -Force

			Get-InstalledModule -Name "BurntToast"

    			Write-Host "BurntToast is installed...Ending Script"

    			Start-sleep -Seconds 6

    			Exit

		}