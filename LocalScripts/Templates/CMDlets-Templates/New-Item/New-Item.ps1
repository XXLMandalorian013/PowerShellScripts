    #ReadMe
<#

New-Item
    
[Online Version](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.2)

#>

#Script

#Add Reg Key

#Make sure to keep the Registry:: before the actual Reg key.

New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\TestKey' –Force

