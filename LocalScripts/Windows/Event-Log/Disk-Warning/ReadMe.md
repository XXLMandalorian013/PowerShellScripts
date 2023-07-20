    #ReadMe
<#

# Disk-Warning

## DESCRIPTION

Adds a file name extension to a supplied name.  

## Notes

Notes here.

## PARAMETER Name

Specifies the file name.


## PARAMETER Extension

Specifies the extension. "Txt" is the default.

## INPUTS

None.

## OUTPUTS

System.String. Disk warnings outputs over the span of a week.

## EXAMPLE

PS C:\Users\DAM> Get-EventLog -LogName "System" -Source "disk" -After $Begin -Before $End

Index              : 250772
EntryType          : Warning
InstanceId         : 2147745843
Message            : An error was detected on device \Device\Harddisk2\DR4 during a paging operation.
Category           : (0)
CategoryNumber     : 0
ReplacementStrings : {\Device\Harddisk2\DR4}
Source             : disk
TimeGenerated      : 6/19/2023 10:59:52 AM
TimeWritten        : 6/19/2023 10:59:52 AM
UserName           :

Index              : 250770
EntryType          : Warning
InstanceId         : 2147745945
Message            : The IO operation at logical block address 0x58 for Disk 2 (PDO name:
                     \Device\000003af) was retried.
Category           : (0)
CategoryNumber     : 0
ReplacementStrings : {\Device\Harddisk2\DR4, 0x58, 2, \Device\000003af}
Source             : disk
TimeGenerated      : 6/19/2023 10:59:51 AM
TimeWritten        : 6/19/2023 10:59:51 AM
UserName           :


VERBOSE: The current time and date is 07/20/2023 11:01:05

## LINK

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3)

[about_Eventlogs](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_eventlogs?view=powershell-5.1&viewFallbackFrom=powershell-7.2)

[Get-EventLog](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-eventlog?view=powershell-5.1&viewFallbackFrom=powershell-7.3)

[Get-Date](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.3S)

[Format-List](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/format-list?view=powershell-7.3)
