    #ReadMe
<#

Remove-Item

[Online Version](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.2)

#>

#Script

#Remove Reg Key

#When working w/ the Reg, make sure to keep the Registry:: before the actual Reg key.

Remove-Item -Path 'Registry::HKEY_CURRENT_USER\TestKey' –Force