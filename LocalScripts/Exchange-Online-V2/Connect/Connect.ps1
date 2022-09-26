    #ReadMe
<#
    
    .SYNOPSIS

        Connects to Exchange Online V2.

    .Notes

        V2 works in PS 7.X.X.
    


    .INPUTS
        
        String (UserPrincialName)


    .OUTPUTS
        
        @{Name=ExchangeOnlineManagement} installed

        Enter UserPrincialName:

        @{Name=ExchangeOnlineManagement} is not installed


    .LINK
        
        [Connect-ExchangeOnline OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/exchange/connect-exchangeonline?view=exchange-ps)

        [Everything you wanted to know about the if OnlineVersion](https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2)

        [about_Operators OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.2)

#>

#Script

#Connect to Exchange Online V2 w/ Modern Auth and MFA enabled w/ module check.

$ModuleName = 'ExchangeOnlineManagement'

$Module = Get-InstalledModule -Name "$ModuleName" | Select-Object 'Name'

if ( $Module -eq $Module )
{
    Write-Host "$Module installed" -BackgroundColor Green

    $Email = Read-Host 'Enter UserPrincialName'

    Connect-ExchangeOnline -UserPrincipalName $Email

}
else
{
    Write-Host "$Module is not installed"
}

