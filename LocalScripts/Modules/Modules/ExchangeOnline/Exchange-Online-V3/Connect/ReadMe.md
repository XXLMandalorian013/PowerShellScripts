# SYNOPSIS

Connects to Exchange Online V3.

# .DESCRIPTION

1. Checks your network connection.
2. Verifies if exchange is up.
3. Looks to see if you already have an active connection, If not it connects while making sure the V2 module is installed.
4. If ExchangeOnline module it not installed, the script installs it.

# Notes

V2 works in PS 7.X.X.

# INPUTS

String (UserPrincialName)

# OUTPUTS

## **No issues**

UserPrincipalName: email@domain.com
Network connection confirmed!
outlook.office365.com is up!
Starting Connection to ExchangeOnlineInternalSession
ExchangeOnlineManagement Module is installed

Opened    ExchangeOnlineInternalSession_

## **Exchange module not installed**

UserPrincipalName: email@domain.com
Network connection confirmed!
outlook.office365.com is up!
Starting connection to ExchangeOnlineInternalSession
Get-Package: No match was found for the specified search criteria and module names 'ExchangeOnlineManagement'.

ExchangeOnlineManagement is not installed...Installing

Untrusted repository
You are installing the modules from an untrusted repository. If you trust this repository, change its
InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you want to install the modules from
'PSGallery'?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): y

## **Already Connected to Exchange**

Exception:
Line |
   8 |      Throw "Your are already connected to $PSSessionsName"
     |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | Your are already connected to @{Name=ExchangeOnlineInternalSession

## **Network Issues**

WARNING: Name resolution of internetbeacon.msedge.net failed
Exception:
Line |
  56 |      Throw "Check network connection"
     |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | Check network connection

## **outlook.office365.com is down**

outlook.office365.com is down...see https://portal.office.com/adminportal/home?#/servicehealth

# LINKS

[Connect-ExchangeOnline OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/exchange/connect-exchangeonline?view=exchange-ps)

[Everything you wanted to know about if OnlineVersion](https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2)

[about_Operators OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.2)
