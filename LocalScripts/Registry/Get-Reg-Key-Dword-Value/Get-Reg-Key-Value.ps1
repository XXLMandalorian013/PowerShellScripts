    #ReadMe
<#
    
    .DESCRIPTION
        
        Gets Reg Key Value.
    
    
    .Notes
    

    .PARAMETER Name
        
        Specifies the file name.

    
    .PARAMETER Extension
        
        Specifies the extension. "Txt" is the default.


    .INPUTS
        
        None. You cannot pipe objects to Add-Extension.


    .OUTPUTS
        
        System.String. Add-Extension returns a string with the extension or file name.

    .EXAMPLE
        
        Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' -Name 'SystemRestorePointCreationFrequency'

        SystemRestorePointCreationFrequency : 0
        PSPath                              : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore
        PSParentPath                        : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion
        PSChildName                         : SystemRestore
        PSProvider                          : Microsoft.PowerShell.Core\Registry

    .LINK
        
        [OnlineVersion](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-itemproperty?view=powershell-7.2)

#>

#Script

Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' -Name 'SystemRestorePointCreationFrequency'