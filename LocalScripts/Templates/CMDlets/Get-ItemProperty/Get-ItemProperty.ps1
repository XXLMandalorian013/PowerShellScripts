    #ReadMe
<#
    
Get-ItemProperty

## Related Links

* [OnlineVersion](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-itemproperty?view=powershell-7.2)

#>

#Script

#Get Reg Key

#When working w/ the Reg, make sure to keep the Registry:: before the actual Reg key.

Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore'
