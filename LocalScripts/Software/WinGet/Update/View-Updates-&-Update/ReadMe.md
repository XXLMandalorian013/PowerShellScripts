# Get-Log-Content

## SYNOPSIS

Get a log file and its contents.

## DESCRIPTION

1. It lists the Logs.
2. Prmpts for the user to enter a .log name.
3. Shows the .logs content.

## Notes

Works in PS 5.1 and up.

## INPUTS

Prompts for a .log name and gets its content.

## OUTPUTS

System.String.

Log list:

Mode                 LastWriteTime         Length Name

---

-a----        10/27/2022   8:31 AM            682 WinGet-2022-10-27-08-31-29.460.log

-a----        10/27/2022   8:31 AM           6835 WinGet-2022-10-27-08-31-45.446.log

-a----        10/27/2022   8:34 AM           2758 WinGet-2022-10-27-08-34-43.481.log

-a----        10/27/2022   8:34 AM           2621 WinGet-2022-10-27-08-34-51.302.log

Log Example Once Specified:

2022-10-27 08:31:29.465 [CORE] WinGet, version [1.3.2691], activity [{4630859C-CAEB-40A3-9A88-B46EE4D32EE5}]

2022-10-27 08:31:29.467 [CORE] OS: Windows.Desktop v10.0.19044.2130

2022-10-27 08:31:29.467 [CORE] Command line Args: "C:\Users\HUA\AppData\Local\Microsoft\WindowsApps\winget.exe"

2022-10-27 08:31:29.467 [CORE] Package: Microsoft.DesktopAppInstaller v1.18.2691.0

2022-10-27 08:31:29.467 [CORE] IsCOMCall:0; Caller: winget-cli

2022-10-27 08:31:29.477 [CLI ] WinGet invoked with arguments:

2022-10-27 08:31:29.477 [CLI ] Leaf command to execute: root

2022-10-27 08:31:29.478 [CLI ] Executing command: root

2022-10-27 08:31:29.503 [CLI ] Leaf command succeeded: root

## LINK

[Get-ChildItem Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.2)

[Get-Content Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content?view=powershell-7.2)
