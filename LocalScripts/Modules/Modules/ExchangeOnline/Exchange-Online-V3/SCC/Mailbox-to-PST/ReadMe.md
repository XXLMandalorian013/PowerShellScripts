# SYNOPSIS

Backups a users EXO mailbox.

## DESCRIPTION

1. Asks you to name the search and the users email.
2. Makes sure you are are running the script administrativly in PS 7.X.X and are connected to EXO and the SCC.
3. Creates a Compliance Search and starts it, based on step 1.s peramiters.
4. Check if Compliance Search is done and if so, it starts exporting it.
5. Check if Compliance Search Action exporting is done, if so it moves onto if the .pst is ready for download.
6. Checks if the .pst is reaedy to be downloaded, if so it opens the URl to the MS Compliance Center in Edge as ClickOnce is required to download w/ the MS export tool upon first download and use.

## Notes

As EXOV3 only work in PS 7.X.X this script run only in PS 7.X.X.

## INPUTS

System.String.

SearchName: User-Mailbox-Export

EXLocation: email@domain.com

## OUTPUTS

System.String.

This script is running in 7.2.6.

Your are not connected to ExchangeOnline...Connecting

Your are not connected to the SCC...Connecting

Name               RunBy JobEndTime Status

---

User-Mailbox-Export                  NotStarted

Status for User-Mailbox-Export is Starting. Checking again in 1 minute...

User-Mailbox-Export completed...Starting Export

Status for User-Mailbox-Export is Starting. Checking again in 1 minute...

Status for User-Mailbox-Export is Starting. Checking again in 1 minute...

Status for User-Mailbox-Export is Starting. Checking again in 1 minute...

User-Mailbox-Export is Completed opening the SCC Export URL in Edge, please seleted it and manually download it.

If this is the first time running this, you will be prompted to download the eDescovery Export Tool.

## LINK

[Get-ManagementRole OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/exchange/get-managementrole?view=exchange-ps)

[If-ElseIf-Else OnlineVersion](https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2)

[Connect-to-SCC OnlineVersion](https://learn.microsoft.com/en-us/powershell/exchange/connect-to-scc-powershell?view=exchange-ps)

[New-ComplianceSearch OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/exchange/new-compliancesearch?view=exchange-ps)

[Start-ComplianceSearch OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/exchange/start-compliancesearch?view=exchange-ps)

[Get-ComplianceSearch OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/exchange/get-compliancecase?view=exchange-ps)

[Get-ComplianceSearchAction OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/exchange/get-compliancesearchaction?view=exchange-ps)

[New-ComplianceSearchAction OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/exchange/new-compliancesearchaction?view=exchange-ps)

[About Operators OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operator_precedence?view=powershell-7.2)

[Do-Until OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.2)

