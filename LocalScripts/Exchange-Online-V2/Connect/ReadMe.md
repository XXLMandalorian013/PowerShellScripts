# SYNOPSIS

    Connects to Exchange Online V2.

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

@{Name=ExchangeOnlineManagement} is not installed

## **Already Connected to Exchange**

Exception:
Line |
   8 |      Throw "Your are already connected to $PSSessionsName"
     |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | Your are already connected to @{Name=ExchangeOnlineInternalSession

## **Network Issues**

No Network connection or outlook.office365.com is down...see https://portal.office.com/adminportal/home?#/servicehealth

# LINKS

    [Connect-ExchangeOnline OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/exchange/connect-exchangeonline?view=exchange-ps)

    [Everything you wanted to know about the if OnlineVersion](https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2)

    [about_Operators OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.2)
