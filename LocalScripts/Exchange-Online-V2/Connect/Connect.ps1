    #ReadMe
<#
    
    .SYNOPSIS

        Connects to Exchange Online V2.

    .DESCRIPTION

        First this script checks if exchange is up, then it looks to see if you already have an active connection. If not, it connects while making sure the V2 module is installed. If its not, the script installs it.

    .Notes

        V2 only works in PS 7.X.X.

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


[CmdletBinding()]
param (
    [Parameter(Mandatory,HelpMessage='Enter a UserPrincical Name/Email')]
    [string]$UserPrincipalName
)

#Is Exchange down?

if (Test-Connection -TargetName outlook.office365.com -ErrorAction SilentlyContinue)
{
    Write-Host "outlook.office365.com is up!"
}
else
{
    Throw "outlook.office365.com is down...see https://portal.office.com/adminportal/home?#/servicehealth"
}

#Am I already connected to ExchangeOnline?

$PSSessionsName = Get-PSSession | Select-Object -Property "Name"

$PSSessionsState = Get-PSSession | Select-Object -Property "State"

if ("$PSSessionsName" -ne "$PSSessionsState") {
    Throw "Your are already connected to $PSSessionsName"
}   
else
{
    Write-Host "Starting Conection to $PSSessionsName"
}

#Connect to exchange/module install check

$ModuleName = Get-InstalledModule -Name 'ExchangeOnlineManagement'

$Module = $ModuleName.Name

if ( "$Module -ErrorAction SilentlyContinue")
{
    Write-Host "$Module is installed"

    Connect-ExchangeOnline -UserPrincipalName $UserPrincipalName

    Get-PSSession | Select-Object -Property State, Name
}
else
{
    Write-Host "$Module is not installed...Installing"

    Install-Module -Name ExchangeOnlineManagement -MinimumVersion 2.0.5

    Connect-ExchangeOnline -UserPrincipalName $UserPrincipalName
    
    Get-PSSession | Select-Object -Property State, Name
}

