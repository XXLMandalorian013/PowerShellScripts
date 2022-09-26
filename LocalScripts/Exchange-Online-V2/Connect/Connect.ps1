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

if (Get-InstalledModule -Name 'ExchangeOnlineManagement' | Select-Object 'Name' -ErrorAction SilentlyContinue)
{
    Write-Host "$Module is installed" -BackgroundColor Green

    $Email = Read-Host 'Enter UserPrincialName'

    Connect-ExchangeOnline -UserPrincipalName $Email

}
else
{
    Write-Host "$Module is not installed"

    Install-Module -Name ExchangeOnlineManagement -MinimumVersion 2.0.5

    $Email = Read-Host 'Enter UserPrincialName'

    Connect-ExchangeOnline -UserPrincipalName $Email
}

