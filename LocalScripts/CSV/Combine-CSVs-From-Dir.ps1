    #ReadMe
<#

.DESCRIPTION
        
Combines all .csv's from a specified dir and names it.  
    
.Notes

Works in PS 5.1 and later.

.INPUTS
        
None.

.OUTPUTS
        
None.

.LINK

[Get-ChildItem Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.3)

[ForEach-Object Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/foreach-object?view=powershell-7.3) 

[Import-CSV Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/import-csv?view=powershell-7.3)

[Add-Member Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-member?view=powershell-7.3)

[About_Assignment_Operators Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_assignment_operators?view=powershell-7.3)

[Export-CSV Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-csv?view=powershell-7.3)


#>

#Script


#This script must be ran as admin to work.

if (! ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Error "This script requires Administrator rights. To run this cmdlet, start PowerShell with the `"Run as administrator`" option."
    return
}

#Grabs .csv's in dir and combines them.

$sourcefolder = "\\Server\Folder\Folder"
$sourcefiles = Get-ChildItem -Path $sourcefolder -Filter *.csv

$SourceFiles |
ForEach-Object {

    $output = Import-Csv -Path $_.FullName |
   
    Add-Member -MemberType NoteProperty -Name 'Filename' -Value $_.Name -Passthru
    $combinedoutput +=  $output
} 

$combinedoutput | Export-Csv "\\Server\Folder\filenamehere.csv" -NoTypeInformation


