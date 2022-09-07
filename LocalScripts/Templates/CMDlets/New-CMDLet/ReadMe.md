# NAME
    Get-ScheduledTask

# SYNOPSIS
    Gets the task definition object of a scheduled task that is registered on the local computer.


# SYNTAX
    Get-ScheduledTask [[-TaskName] <String[]>] [[-TaskPath] <String[]>] [-CimSession <CimSession[]>] [-ThrottleLimit <Int32>] [<CommonParameters>]


# DESCRIPTION
    The Get-ScheduledTask cmdlet gets the task definition object of a scheduled task that is registered on a computer.



# PARAMETERS
    -CimSession [<CimSession[]>]
        Runs the cmdlet in a remote session or on a remote computer. Enter a computer name or a session object, such as the output of a New-CimSession or Get-CimSession cmdlet. The
        default is the current session on the local computer.

        Required?                    false
        Position?                    named
        Default value                none
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -TaskName [<String[]>]
        Specifies an array of one or more names of a scheduled task.

        Required?                    false
        Position?                    1
        Default value                none
        Accept pipeline input?       True (ByPropertyName)
        Accept wildcard characters?  false

    -TaskPath [<String[]>]
        Specifies an array of one or more paths for scheduled tasks in Task Scheduler namespace. You can use \ for the root folder. If you do not specify a path, the cmdlet uses the
        root folder.

        Required?                    false
        Position?                    2
        Default value                none
        Accept pipeline input?       True (ByPropertyName)
        Accept wildcard characters?  false

    -ThrottleLimit [<Int32>]
        Specifies the maximum number of concurrent operations that can be established to run the cmdlet. If this parameter is omitted or a value of 0 is entered, then Windows
        PowerShellr calculates an optimum throttle limit for the cmdlet based on the number of CIM cmdlets that are running on the computer. The throttle limit applies only to the
        current cmdlet, not to the session or to the computer.

        Required?                    false
        Position?                    named
        Default value                none
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,

# EXAMPLES

    Example 2: Get an array of scheduled task definition objects

    PS C:\> Get-ScheduledTask -TaskPath "\UpdateTasks\"
    TaskPath                          TaskName                        State
    --------                          --------                        --------
    \UpdateTasks                      UpdateApps                      Ready
    \UpdateTasks                      UpdateDrivers                   Ready
    \UpdateTasks                      UpdateOS                        Disabled

    \UpdateTasks                      UpdateSignatures                Running

    This command gets an array of task definitions objects from the UpdateTasks folder.

# RELATED LINKS
[https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/get-scheduledtask?view=windowsserver2022-ps](URL "Online Version:")
    