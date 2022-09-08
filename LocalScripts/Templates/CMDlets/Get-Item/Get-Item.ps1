    #ReadMe
<#
    
NAME
    Get-Item

Links
    https://go.microsoft.com/fwlink/?LinkID=113319.

#>

#Script

Get-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore'

#Double quotes used here due to variable.
Get-Item -Path "$env:TEM\UnlimitedSystemRestorePoints.reg"


