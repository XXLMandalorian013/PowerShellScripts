    #ReadMe
<#
    
NAME
    Get-Item

Links
    https://go.microsoft.com/fwlink/?LinkID=113319.

#>

#Script

#Reg key

#When working w/ the Reg, make sure to keep the Registry:: before the actual Reg key.

Get-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore'


#Get's file in a folder

#Double quotes used here due to variable.

Get-Item -Path "$env:TEM\UnlimitedSystemRestorePoints.reg"


