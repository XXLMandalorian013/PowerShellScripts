    #ReadMe
<#

# Install-Module

## Links

[install-module OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/powershellget/install-module?view=powershell-7.2)

#>  


#Script


#Exchange Online module 2.0.5 (V2) and newer requires PS 7.X.X.


if ($PSVersionTable.PSVersion.Major -eq 7) {
		
	Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
} 

else {
	
    Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 7.X.X...Ending Script" -WarningAction Inquire
		
	Start-Sleep -Seconds 3

	Exit
}


#Module install check.

$ModuleName = Get-InstalledModule -Name 'ExchangeOnlineManagement'


$Module = $ModuleName.Name


if ($Module | Select-Object -Property 'Name', 'Version' -erroraction silentlycontinue)
{
    Write-Host "$Module Module is installed"
}
else
{
    Write-Host "ExampleModule is not installed...Installing"

    Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.5
}




