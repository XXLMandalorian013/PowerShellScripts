$PCName = $env:computername
$UserName = $env:UserName

$CSV = Get-ScheduledTask -TaskPath "\Automated-Restore-Point\" | Get-ScheduledTaskInfo

$CSV | Export-Csv -Path (Join-Path -Path "\\Server\Folder\Automated-Restore-Point\User\Script-Check\Script-Output" -ChildPath $UserName-$PCName'-Automated-Restore-Point'.csv)
