# Get-ScheduledTaskInfo

* Reference

Module:[ScheduledTasks](https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/?view=windowsserver2022-ps)

Gets run-time information for a scheduled task.

## Syntax

**PowerShell**Copy

```
Get-ScheduledTaskInfo
   [-TaskName] <String>
   [[-TaskPath] <String>]
   [-CimSession <CimSession[]>]
   [-ThrottleLimit <Int32>]
   [-AsJob]
   [<CommonParameters>]
```

**PowerShell**Copy

```
Get-ScheduledTaskInfo
   [-InputObject] <CimInstance>
   [-CimSession <CimSession[]>]
   [-ThrottleLimit <Int32>]
   [-AsJob]
   [<CommonParameters>]
```

## Description

The **Get-ScheduledTaskInfo** cmdlet gets the last run-time information for a scheduled task. You can use the *TaskName* parameter to specify a scheduled task, or you can use the *InputObject* parameter to specify the scheduled task.

## Examples

### Example 1: Get run-time information by using a task name

**PowerShell**Copy

```
PS C:\> Get-ScheduledTaskInfo -TaskName "\Sample\SchedTask01"
```

This command gets run-time information for the scheduled task named \Sample\SchedTask01.

### Example 2: Get run-time information by using an input object

**PowerShell**Copy

```
PS C:\>Get-ScheduledTask -TaskPath "\Sample\" | Get-ScheduledTaskInfo
```

In this example, the Get-ScheduledTask cmdlet gets all the scheduled tasks in the path \Sample, and pipes the results to the **Get-ScheduledTaskInfo** cmdlet.

In the second part of the command, the **Get-ScheduledTaskInfo** cmdlet gets the run-time information for all the scheduled tasks in the path \Sample.

## Parameters

-AsJob

Runs the cmdlet as a background job. Use this parameter to run commands that take a long time to complete.

| Type:                       | **SwitchParameter** |
| --------------------------- | ------------------------- |
| Position:                   | Named                     |
| Default value:              | None                      |
| Accept pipeline input:      | False                     |
| Accept wildcard characters: | False                     |

-CimSession

Runs the cmdlet in a remote session or on a remote computer. Enter a computer name or a session object, such as the output of a [New-CimSession](https://go.microsoft.com/fwlink/p/?LinkId=227967) or [Get-CimSession](https://go.microsoft.com/fwlink/p/?LinkId=227966) cmdlet. The default is the current session on the local computer.

| Type:                       | **CimSession**[] |
| --------------------------- | ---------------------- |
| Aliases:                    | Session                |
| Position:                   | Named                  |
| Default value:              | None                   |
| Accept pipeline input:      | False                  |
| Accept wildcard characters: | False                  |

-InputObject

Specifies the input object that is used in a pipeline command.

| Type:                       | **CimInstance** |
| --------------------------- | --------------------- |
| Position:                   | 0                     |
| Default value:              | None                  |
| Accept pipeline input:      | True                  |
| Accept wildcard characters: | False                 |

-TaskName

Specifies a name of a scheduled task.

| Type:                       | **String** |
| --------------------------- | ---------------- |
| Position:                   | 0                |
| Default value:              | None             |
| Accept pipeline input:      | False            |
| Accept wildcard characters: | False            |

-TaskPath

Specifies an array of one or more paths for scheduled tasks in Task Scheduler namespace. You can use **"*"** for a wildcard character query. You can use  **\** * for the root folder. To specify a full TaskPath you need to include the leading and trailing  **\** . If you do not specify a path, the cmdlet uses the root folder.

| Type:                       | **String** |
| --------------------------- | ---------------- |
| Position:                   | 1                |
| Default value:              | None             |
| Accept pipeline input:      | False            |
| Accept wildcard characters: | False            |

-ThrottleLimit

Specifies the maximum number of concurrent operations that can be established to run the cmdlet. If this parameter is omitted or a value of `0` is entered, then Windows PowerShell® calculates an optimum throttle limit for the cmdlet based on the number of CIM cmdlets that are running on the computer. The throttle limit applies only to the current cmdlet, not to the session or to the computer.

| Type:                       | **Int32** |
| --------------------------- | --------------- |
| Position:                   | Named           |
| Default value:              | None            |
| Accept pipeline input:      | False           |
| Accept wildcard characters: | False           |

## Outputs

**[CimInstance](https://docs.microsoft.com/en-us/dotnet/api/microsoft.management.infrastructure.ciminstance#MSFT_TaskDynamicInfo)**

## Related Links

[OnlineVersion](https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/get-scheduledtaskinfo?view=windowsserver2022-ps)

* [Get-ScheduledTask](https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/get-scheduledtask?view=windowsserver2022-ps)
* [New-ScheduledTask](https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtask?view=windowsserver2022-ps)
* [Enable-ScheduledTask](https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/enable-scheduledtask?view=windowsserver2022-ps)
* [Register-ScheduledTask](https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/register-scheduledtask?view=windowsserver2022-ps)
* [Start-ScheduledTask](https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/start-scheduledtask?view=windowsserver2022-ps)
* [Set-ScheduledTask](https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/set-scheduledtask?view=windowsserver2022-ps)
