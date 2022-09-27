    #ReadMe
   


#Script

#Install Module

Install-Module -Name ExchangeOnlineManagement 


#Install Module w/ version minimum

Install-Module -Name ExchangeOnlineManagement -MinimumVersion 2.0.5


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

    Install-Module -Name ExchangeOnlineManagement -MinimumVersion 2.0.5
}




