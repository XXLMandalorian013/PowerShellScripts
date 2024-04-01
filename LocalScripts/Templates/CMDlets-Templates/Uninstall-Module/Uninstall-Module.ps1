    #ReadMe
<#


    .SYNOPSIS
    
        Uninstalls a module.   

    .Notes

        Works in PS 5.1 and up.

    .Link

    [Uninstall-Module OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/powershellget/uninstall-module?view=powershell-7.2)     
#>  


#Script


#Uninstall-Module

Uninstall-Module -Name 'ExchangeOnlineManagement'

#Checks if module is installed, if so it uninstalls it.

$ModuleName = Get-InstalledModule -Name 'ExchangeOnlineManagement'


$Module = $ModuleName.Name


if ($Module | Select-Object -Property 'Name', 'Version' -erroraction silentlycontinue)
{
    Write-Host "$Module Module is installed"

    Connect-ExchangeOnline -UserPrincipalName $UserPrincipalName

    Get-PSSession | Select-Object -Property State, Name
}
else
{
    Write-Host "ExchangeOnlineManagement is not installed...Installing"

    Install-Module -Name ExchangeOnlineManagement -MinimumVersion 2.0.5

    Connect-ExchangeOnline -UserPrincipalName $UserPrincipalName

    Get-PSSession | Select-Object -Property State, Name
}