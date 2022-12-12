    #ReadMe
<#

.DESCRIPTION
        
Gets all folders/files in a dir and sorts them largest to smallest and exports it to a .csv.   
    
.Notes

Works in PS 5.1 and later.

.INPUTS
        
None.

.OUTPUTS
        
System.String.
      

.LINK
        
[Get-ChildItem Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.3) 

[Sort-Object Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/sort-object?view=powershell-7.3)

[Format-Table Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/format-table?view=powershell-7.3)

[Export-CSV Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-csv?view=powershell-7.3)

#>


#Script

$Server = '\\HAWA-COL05\Design'

$DirSize = foreach ($name in Get-ChildItem $Server -Recurse | Sort-Object -Property Length -Descending ) {
    $name | Select-Object 'ResolvedTarget','Length'
  }

$ExportPath = "\\hawa-col04\Support_Tools\Scripts\PS\Local Scripts\DriveSizeExport"

$DirSize | Export-Csv -Path "$ExportPath\DriveSizeExport.csv"


