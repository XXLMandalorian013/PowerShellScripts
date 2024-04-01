    #ReadMe
<#
    
    .SYNOPSIS

        Connects to Exchange Online V2.

    .DESCRIPTION

        1. Checks your network connection.
        2. Verifies if exchange is up.
        3. Looks to see if you already have an active connection, If not it connects while making sure the V2 module is installed.
        4. If ExchangeOnline module it not installed, the script installs it.

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

        [Get-PSSession OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-pssession?view=powershell-7.2)

        [Test-NetConnection OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection?view=windowsserver2022-ps)

        [Test-Connection Online](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-connection?view=powershell-7.2)

#>

#Script

[CmdletBinding()]
param (
    [Parameter(Mandatory,HelpMessage='Enter a UserPrincical Name/Email')]
    [string]$UserPrincipalName
)


#Exchange Online module 2.0.5 (V2) and newer requires PS 7.X.X.


if ($PSVersionTable.PSVersion.Major -eq 7) {
		
	Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
} 

else {
	
    Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 7.X.X...Ending Script" -WarningAction Inquire
		
	Start-Sleep -Seconds 3

	Exit
}

#Can I dial out?

$NetworkConnection = Test-NetConnection | Select-Object 'PingSucceeded'

if ($NetworkConnection -match 'True')
{
    Write-Host "Network connection confirmed!"
}
else
{
    Throw "Check network connection"
}

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

if ("$PSSessionsName" -match 'ExchangeOnlineInternalSession') 
{
    Throw "Your are already connected to $PSSessionsName"
}   
else
{
    Write-Host 'Starting connection to ExchangeOnlineInternalSession'
}   

#Module install check/Connect to exchange.

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

