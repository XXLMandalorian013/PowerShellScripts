#ReadMe

<#

.DESCRIPTION
        
Grabs .csv's in a dir, sorts A-Z, weeds out repeates and combines them into one .csv.  
    
.Notes

Works in PS 5.1 and later.

.INPUTS
        
None.

.OUTPUTS
        
None.

.LINK

[Get-ChildItem Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.3)

[Sort-Object Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/sort-object?view=powershell-7.3)

[Import-CSV Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/import-csv?view=powershell-7.3)

[Export-CSV Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-csv?view=powershell-7.3)


#>

#This script must be ran as admin to work.

if (! ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Error "This script requires Administrator rights. To run this cmdlet, start PowerShell with the `"Run as administrator`" option."
    return
}

#Grabs .csv's in a dir, weeds out repeates and combines them into one .csv.

$SourceFolder = "\\Server\Folder\Folder"

$SourceFiles = Get-ChildItem -Path $sourcefolder -Filter *.csv 

$CombinedCSVs = Import-CSV -Path $SourceFiles

$CombinedCSVs | Sort-Object -Property DisplayName -Unique | Export-CSV -Path "\\Server\Folder\FileNameHere.csv"

