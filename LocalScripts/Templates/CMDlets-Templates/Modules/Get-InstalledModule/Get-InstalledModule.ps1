    #ReadMe
<#

# Get-InstalledModule

## Notes

    Works in 5.1 and newer.

## Links

    [Get-InstalledModule OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/powershellget/get-installedmodule?view=powershell-7.2)   
#>  


#Script

#Get all installed Module

Get-installedmodule

#Get specific installed Module by name

Get-installedmodule -Name ExchangeOnlineManagement

#Get specific installed Module by name

$ModuleName = Get-InstalledModule -Name 'ExchangeOnlineManagement'

$Module = $ModuleName.Name

$Module


