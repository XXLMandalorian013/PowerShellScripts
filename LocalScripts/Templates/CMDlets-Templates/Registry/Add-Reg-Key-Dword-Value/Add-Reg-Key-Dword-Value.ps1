    #ReadMe
<#

Name    
    New-ItemProperty

## Related Links

[OnlineVersion] (https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/New-ItemProperty?view=powershell-7.2&viewFallbackFrom=powershell-3.0)

#>

#Script

#Make sure to keep the Registry:: before the actual Reg key.

New-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' -Name 'SystemRestorePointCreationFrequency' -Value '0' -Type 'DWORD'