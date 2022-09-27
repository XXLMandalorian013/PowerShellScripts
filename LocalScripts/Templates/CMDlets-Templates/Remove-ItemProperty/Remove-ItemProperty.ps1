    #ReadMe
<#
    
Remove-ItemProperty

[Oneline Version](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-itemproperty?view=powershell-7.2)

[Online Version](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.2)


#>

#Script

#Remove a RegKey "DWORD"

#When working w/ the Reg make sure to keep the Registry:: before the actual Reg key.

Remove-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\SOFTWARE\Autodesk\AutoCAD\R19.1\ACAD-D006:409\Profiles\HAWA MEP 2018' -Name  'Test' –Force


#Remove a RegKey

#When working w/ the Reg make sure to keep the Registry:: before the actual Reg key.

Remove-Item -Path 'Registry::HKEY_CURRENT_USER\TestKey' –Force