    #ReadMe
<#

Name
    
Export-Csv
    
## Related Links

[OnlineVersion](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-csv?view=powershell-7.2)

#>

#Script

$CSV = Get-ScheduledTaskInfo -TaskName "Automated-Restore-Point"

$CSV | Export-Csv -Path (Join-Path -Path "\\hawa-col04\Support_Tools\Scripts\PS\Local Scripts\Automated-Restore-Point\Script-Check\Script-Output" -ChildPath $UserName-$PCName'-Automated-Restore-Point'.csv)
