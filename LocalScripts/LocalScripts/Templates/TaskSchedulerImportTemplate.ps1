$ProgramName = "C:\Program Files\PowerShell\7\pwsh.exe"

if(Get-Item -Path $ProgramName -ErrorAction Ignore)
{

Write-Host "Program Exists"

}
else
{
Write-Host "Program Doesn't Exists"

#https://docs.microsoft.com/en-us/windows/package-manager/winget/install
#Silently installs Program PS 7.2
winget install --ID Microsoft.PowerShell --source winget --version 7.2.1.0 --accept-source-agreements --accept-package-agreements --silent
}

$Domain = $env:USERDNSDOMAIN
$UserName = $env:UserName

#New-ScheduledTask: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtask?view=windowsserver2022-ps

#New-ScheduledTaskAction: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtaskaction?view=windowsserver2022-ps
# -Execuite is the program to be ran and -Argument is the file to be ran ie a .ps1
$TSActions = New-ScheduledTaskAction -Execute "pwsh.exe" -Argument '"\\ServerName\Folder\SFC.ps1"'

#New-ScheduledTaskSettings: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasksettingsset?view=windowsserver2022-ps
$TSSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -Compatibility Win7 -DontStopOnIdleEnd -RunOnlyIfNetworkAvailable -WakeToRun -StartWhenAvailable  

#New-ScheduledTaskTrigger: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasktrigger?view=windowsserver2022-ps
$TSTriggers = New-ScheduledTaskTrigger -Weekly -WeeksInterval 1 -DaysOfWeek Tuesday -At 9pm

#New-ScheduledTaskPrincipal: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtaskprincipal?view=windowsserver2022-ps
$TSPrincipal = New-ScheduledTaskPrincipal -User $Domain\$UserName -RunLevel Highest

#Register-ScheduledTask: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/register-scheduledtask?view=windowsserver2022-ps
Register-ScheduledTask -Action $TSActions -Trigger $TSTriggers -Settings $TSSettings -Principal $TSPrincipal -TaskName "SFC" -Description "Runs SFC /scannow to repair win system image"