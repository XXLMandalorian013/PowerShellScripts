    #ReadMe

<#

    .DESCRIPTION

    Gets Reg Key Value.

    .Notes

    .PARAMETERName

    Specifies the file name.

    .PARAMETERExtension

    Specifies the extension. "Txt" is the default.

    .INPUTS

    None. You cannot pipe objects to Add-Extension.

    .OUTPUTS

    System.String. Add-Extension returns a string with the extension or file name.

    .EXAMPLE

    PS C:\Users\MEFP\Documents> Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore'

    RPSessionInterval              : 1

    FirstRun                       : 0

    LastIndex                      : 142

    SRInitDone                     : 1

    LastMainenanceTaskRunTimeStamp : 133068616886618662

    PSPath                         : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\SystemRestore

    PSParentPath                   : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsNT\CurrentVersion

    PSChildName                    : SystemRestore

    PSProvider                     : Microsoft.PowerShell.Core\Registry

    .LINK

    [OnlineVersion](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-itemproperty?view=powershell-7.2)
