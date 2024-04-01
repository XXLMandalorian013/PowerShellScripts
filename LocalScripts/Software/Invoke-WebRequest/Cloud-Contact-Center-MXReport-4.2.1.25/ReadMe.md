# Windows MSI WebRoot Agent Installer.

## SYNOPSIS
Downloads and installs Windows MSI WebRoot Agent Installer if not already installed. It also will make sure another AV is not already installed.
That AV must be defined in the Install-WebRoot finction paramater.

## Notes

## INPUTS

None.

## OUTPUTS

System.String,

VERBOSE: VS Windows MSI WebRoot Agent Installer: Written by VS-DAM on 2023-10-12
VERBOSE: Checking download link...
VERBOSE: Download link good!
VERBOSE: Downloading .exe installer for wsasme.msi...
VERBOSE: Installing wsasme.msi
VERBOSE: wsasme.msi installed!
VERBOSE: wsasme.msi removed

## LINK

[Write-Verbose](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-verbose?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.3)

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3)

[about_Try_Catch_Finally](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.3)

[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3)

[about_Operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)

[about_Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.3)

[Invoke-WebRequest](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.3)

[msiexec](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/msiexec)

[about_Do](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.3)

[Remove-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.3)

[WebRoot: Deploying Agents](https://docs.webroot.com/us/en/business/administratorguide/administratorguide.htm#1_Admin%20and%20Getting%20Started%20Guide/Deploying%20agents.htm)