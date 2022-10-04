    #ReadMe
<#
   # Uninstall-ModuleName

## Links

[Uninstall-module OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/powershellget/uninstall-module?view=powershell-7.2)

#>

#Script

#Uninstall Module by name

Uninstall-Module -Name 'ExchangeOnlineManagement'

#Uninstall Module if installed

$ModuleName = Get-InstalledModule -Name 'ExchangeOnlineManagement'

$Module = $ModuleName.Name

if ($Module | Select-Object -Property 'Name' -erroraction silentlycontinue)
{
    Write-Host "$Module Module is installed...uninstalling"

    Uninstall-Module -Name $Module

    Get-InstalledModule -Name $Module
}
else
{
    Write-Host "ExampleModule is not installed" 
}

