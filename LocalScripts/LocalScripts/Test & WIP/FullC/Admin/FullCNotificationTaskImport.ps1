#Creates & Imports the Full C:\ check script into Task Scheduler


Write-Host "Creating & Importing the Full C:\ script check into Task Scheduler..."

Start-Sleep -Seconds 4

$Domain = $env:USERDNSDOMAIN
$UserName = $env:UserName

#New-ScheduledTask: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtask?view=windowsserver2022-ps

#New-ScheduledTaskAction: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtaskaction?view=windowsserver2022-ps
# -Execuite is the program to be ran and -Argument is the file to be ran ie a .ps1
$TSActions = New-ScheduledTaskAction -Execute "pwsh.exe" -Argument '"\\hawa-col04\Support_Tools\Scripts\PS\Local Scripts\FullC\PCNotification\PCNotification.ps1"'

#New-ScheduledTaskSettings: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasksettingsset?view=windowsserver2022-ps
$TSSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -Compatibility Win7 -DontStopOnIdleEnd -RunOnlyIfNetworkAvailable -WakeToRun -StartWhenAvailable  

#New-ScheduledTaskTrigger: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasktrigger?view=windowsserver2022-ps
$TSTriggers = New-ScheduledTaskTrigger -Weekly -WeeksInterval 1 -DaysOfWeek Tuesday -At 8am

#New-ScheduledTaskPrincipal: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtaskprincipal?view=windowsserver2022-ps
$TSPrincipal = New-ScheduledTaskPrincipal -User $Domain\$UserName -RunLevel Highest

#Register-ScheduledTask: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/register-scheduledtask?view=windowsserver2022-ps
Register-ScheduledTask -Action $TSActions -Trigger $TSTriggers -Settings $TSSettings -Principal $TSPrincipal -TaskName "OutputOfFullCNotification" -Description "Checks to see the if any users have ouputed to the FullC Output folder and if so notifies DAM's Local PC."




