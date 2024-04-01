    #ReadMe
<#
    
Connect-ExchangeOnline

.Notes

V2 Works in 7.X.X or later

.Link

[OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/exchange/connect-exchangeonline?view=exchange-ps)


#>


#Script


#Connect to Exchange Online V2 w/ Modern Auth and MFA enabled.

Connect-ExchangeOnline -UserPrincipalName emailname@domain.com



#Connect to Exchange Online V2 w/ Modern Auth and MFA enabled w/ module check.

$ModuleName = 'ExchangeOnlineManagement'

$Module = Get-InstalledModule -Name "$ModuleName" | Select-Object 'Name'

if ( $Module -eq $Module )
{
    Write-Host "$Module installed"
}
else
{
    Write-Host "$Module is not installed"
}

$Email = Read-Host 'Enter UserPrincialName'

Connect-ExchangeOnline -UserPrincipalName $Email