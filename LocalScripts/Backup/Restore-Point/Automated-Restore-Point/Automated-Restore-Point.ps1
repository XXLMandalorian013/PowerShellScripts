    #ReadMe
<#
    
    .SYNOPSIS

        Creates a Restore Point.


    .DESCRIPTION

        Prompts for a description of the restore pooint and then creates a Restore Point.


    .OUTPUTS
    
        1.

        WARNING: A new system restore point cannot be created because one has already been created within the past 1440
        minutes. The frequency of restore point creation can be changed by creating the DWORD valuel
        'SystemRestorePointCreationFrequency' under the registry key 'HKLM\Software\Microsoft\Windows
        NT\CurrentVersion\SystemRestore'. The value of this registry key indicates the necessary time interval (in minutes)
        between two restore point creation. The default value is 1440 minutes (24 hours).


    .EXAMPLE
        
        PS> extension "File" "doc"
        File.doc


    .LINK
        
        Online version: http://www.fabrikam.com/extension.html

#>

#Script

#Checks the PS terminal version this is ran in 5.X.X.

	##https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

	#Thanks to dotnVO for the help w/ this
	

if ($PSVersionTable.PSVersion.Major -eq 5) {
		
	Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
} else {
		
	Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 5.X.X...Ending Script" -WarningAction Inquire
		
	Start-Sleep -Seconds 3

	Exit

	}

$Description = Read-Host "Please type what you wish to call this Restore Point..."

Checkpoint-Computer -Description "$Description"

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

