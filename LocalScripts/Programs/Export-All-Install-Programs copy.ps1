    #ReadMe
<#
    
.SYNOPSIS

Adds a file name extension to a supplied name.


.DESCRIPTION
        
Adds a file name extension to a supplied name.  
    
    
.Notes

Notes here.
    

.PARAMETER Name
        
Specifies the file name.

    
.PARAMETER Extension
        
Specifies the extension. "Txt" is the default.


.INPUTS
        
None. You cannot pipe objects to Add-Extension.


.OUTPUTS
        
System.String. Add-Extension returns a string with the extension or file name.


.EXAMPLE
        
PS> extension "File" "doc"
File.doc


.LINK
        
[Get-ItemProperty Online Version](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-itemproperty?view=powershell-7.2) 

[Sort-Object Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/sort-object?view=powershell-7.3)

[Format-Table Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/format-table?view=powershell-7.3)

[Write-Host Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-host?view=powershell-7.3)

[Export-CSV Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-csv?view=powershell-7.3)

#>


#Script


$PCName = $env:computername
$UserName = $env:UserName

#Gets all logged in profile installed programs from the resgistry.

$CUProg = (Get-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object -Property DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object "DisplayName")

#Gets all machine wide installed programs from the resgistry.

$LMProg = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object -Property DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object "DisplayName")


$CUProg | Export-Csv -Path (Join-Path -Path "\\hawa-col04\Support_Tools\Scripts\PS\Local Scripts\AllInstalledPrograms" -ChildPath $UserName-$PCName'-CUProg'.csv)

$LMProg | Export-Csv -Path (Join-Path -Path "\\hawa-col04\Support_Tools\Scripts\PS\Local Scripts\AllInstalledPrograms" -ChildPath $UserName-$PCName'-LMProg'.csv)

