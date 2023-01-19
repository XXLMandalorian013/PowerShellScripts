#ReadMe
<#

PS 7 LTS 7.2.8 web installer
    
.SYNOPSIS

Downloads and installs PowerShell 7 LST 7.2.8 if not already installed.

.PARAMETER Name
        
Specifies the file name.

    
.PARAMETER Extension
        
Specifies the extension. "Txt" is the default.


.INPUTS
        
None. You cannot pipe objects to Add-Extension.


.OUTPUTS
        
System.String. Add-Extension returns a string with the extension or file name.


.LINK
        
[String.TrimStart Method](https://learn.microsoft.com/en-us/dotnet/api/system.string.trimstart?view=net-7.0) 

[Write-Host](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-host?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.3)

[about_Operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)

[Write-Error](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-error?view=powershell-7.3)
 
[about_Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.3)

[Test-NetConnection](https://learn.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection?view=windowsserver2022-ps)

[Invoke-WebRequest](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.3)

[msiexec](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/msiexec)

[about_Do](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.3)

[Remove-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.3)

#>

$ErrorActionPreference = "Stop"


$ProgramPath = "C:\Program Files\PowerShell\7\pwsh.exe"


$ProgramPathShort = $ProgramPath.TrimStart("C:\Program Files\PowerShell\7\")


$URI = 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.8/PowerShell-7.2.8-win-x64.msi'


$URIShort = $URI.TrimStart("https://github.com/PowerShell/PowerShell/releases/download")


$OutFile = 'C:\TEMP'






msiexec.exe /x $OutFile

$wshell = New-Object -ComObject wscript.shell;
$wshell.AppActivate('title of the application window')
Sleep 1
$wshell.SendKeys('ENTER')


