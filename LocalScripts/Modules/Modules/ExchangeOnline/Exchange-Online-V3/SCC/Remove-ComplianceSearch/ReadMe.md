# .SYNOPSIS

Delete a Compliance Search and Export.

## .DESCRIPTION

Prompts for a Compliance Search Name and deletes it if found. It also deletes the export if the search was exported.

## .Notes

Exchange Online module 2.0.5 (V2) and newer requires PS 7.X.X. SCC requires you to be connected to Exchange first.

## .INPUTS

System.String.

## .OUTPUTS

System.String. Add-Extension returns a string with the extension or file name.

## .LINK

[Remove-ComplianceSearch Online Version](https://learn.microsoft.com/en-us/powershell/module/exchange/remove-compliancesearch?view=exchange-ps)
