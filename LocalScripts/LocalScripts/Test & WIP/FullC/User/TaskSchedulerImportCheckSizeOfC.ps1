#Checks to see if PS 7.X is installed, if not its installs it, as I run most of my script this way.

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.2
    
    #https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

        
        $ProgramName = "C:\Program Files\PowerShell\7\pwsh.exe"

        if(Get-Item -Path $ProgramName -ErrorAction Ignore)
        {
        
        Write-Host "PowerShell 7.X is already installed"
        
        }
        else
        {
        Write-Host "PowerShell 7.X install not found...Installing PowerShell 7.X"
        
        #https://docs.microsoft.com/en-us/windows/package-manager/winget/install    
            #Winget info
        #https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?WT.mc_id=THOMASMAURER-blog-thmaure&view=powershell-7
            #PS V 7.2.3.0
            winget install --ID Microsoft.PowerShell --source winget --version 7.2.4.0 --accept-source-agreements --accept-package-agreements --silent --force

        }


$Domain = $env:USERDNSDOMAIN
$UserName = $env:UserName

#New-ScheduledTask: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtask?view=windowsserver2022-ps

#New-ScheduledTaskAction: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtaskaction?view=windowsserver2022-ps
# -Execuite is the program to be ran and -Argument is the file to be ran ie a .ps1
$TSActions = New-ScheduledTaskAction -Execute "pwsh.exe" -Argument '"\\hawa-col04\Support_Tools\Scripts\PS\Modules\FullC\User\CheckSizeOfC.ps1"'

#New-ScheduledTaskSettings: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasksettingsset?view=windowsserver2022-ps
$TSSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -Compatibility Win7 -DontStopOnIdleEnd -RunOnlyIfNetworkAvailable -WakeToRun -StartWhenAvailable  

#New-ScheduledTaskTrigger: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasktrigger?view=windowsserver2022-ps
$TSTriggers = New-ScheduledTaskTrigger -Weekly -WeeksInterval 1 -DaysOfWeek Monday -At 9pm

#New-ScheduledTaskPrincipal: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtaskprincipal?view=windowsserver2022-ps
$TSPrincipal = New-ScheduledTaskPrincipal -User $Domain\$UserName -RunLevel Highest

#Register-ScheduledTask: https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/register-scheduledtask?view=windowsserver2022-ps
Register-ScheduledTask -Action $TSActions -Trigger $TSTriggers -Settings $TSSettings -Principal $TSPrincipal -TaskName "CheckSizeOfC" -Description "Check to see if C < or = 20GB or less."