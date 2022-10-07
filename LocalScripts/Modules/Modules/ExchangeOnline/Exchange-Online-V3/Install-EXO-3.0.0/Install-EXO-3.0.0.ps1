    #ReadMe
<#

# Install-Module

## Links

[install-module OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/powershellget/install-module?view=powershell-7.2)

#>  


#Script


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

    Install-Module -Name ExchangeOnlineManagement -RequiredVersion 3.0.0
}




