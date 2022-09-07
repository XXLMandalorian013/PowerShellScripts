$PCName = $env:computername
$UserName = $env:UserName

$CSV = Get-ScheduledTask -TaskPath "\Automated-Restore-Point\" | Get-ScheduledTaskInfo

$CSV | Export-Csv -Path (Join-Path -Path "\\Server\Folder\ScriptOutput" -ChildPath $UserName-$PCName'-Automated-Restore-Point'.csv)
