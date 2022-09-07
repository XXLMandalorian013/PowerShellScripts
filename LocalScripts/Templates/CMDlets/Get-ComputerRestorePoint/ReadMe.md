 
#        .SYNOPSIS
        Adds a file name extension to a supplied name.

#        .DESCRIPTION
        Adds a file name extension to a supplied name.
        Takes any strings for the file name or extension.

#        .PARAMETER Name
        Specifies the file name.

#        .PARAMETER Extension
        Specifies the extension. "Txt" is the default.

#        .INPUTS
        None. You cannot pipe objects to Add-Extension.

#        .OUTPUTS
        System.String. Add-Extension returns a string with the extension or file name.

#        .EXAMPLE
        PS> extension -name "File"
        File.txt

#        .EXAMPLE
        PS> extension -name "File" -extension "doc"
        File.doc

#        .LINK
        https://knowledge.autodesk.com/support/revit/troubleshooting/caas/CloudHelp/cloudhelp/2021/ENU/Revit-Troubleshooting/files/GUID-3562A7E7-7112-4B6D-97F6-D922BACC0CDF-htm.html

# NAME
    Get-ComputerRestorePoint

# SYNOPSIS
    Gets the restore points on the local computer.


# SYNTAX
    Get-ComputerRestorePoint -LastStatus [<CommonParameters>]

    Get-ComputerRestorePoint [[-RestorePoint] <System.Int32[]>] [<CommonParameters>]


# DESCRIPTION
    The `Get-ComputerRestorePoint` cmdlet gets the local computer's system restore points. And, it can
    display the status of the most recent attempt to restore the computer.

    You can use the information from `Get-ComputerRestorePoint` to select a restore point. For example,
    use a sequence number to identify a restore point for the `Restore-Computer` cmdlet.

    System restore points and the `Get-ComputerRestorePoint` cmdlet are supported only on client
    operating systems such as Windows 10.


# PARAMETERS
    -LastStatus <System.Management.Automation.SwitchParameter>
        Indicates that `Get-ComputerRestorePoint` gets the status of the most recent system restore
        operation.

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -RestorePoint <System.Int32[]>
        Specifies the sequence numbers of the system restore points. You can specify either a single
        sequence number or a comma-separated array of sequence numbers.

        If the RestorePoint parameter isn't specified, `Get-ComputerRestorePoint` returns all the local
        computer's system restore points.

        Required?                    false
        Position?                    0
        Default value                All restore points
        Accept pipeline input?       False
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

# INPUTS
    None
        You can't send objects down the pipeline to `Get-ComputerRestorePoint`.


# OUTPUTS
    System.Management.ManagementObject#root\default\SystemRestore or String
        `Get-ComputerRestorePoint` returns a SystemRestore object, which is an instance of the Windows
        Management Instrumentation (WMI) SystemRestore class.

        When you use the LastStatus parameter, `Get-ComputerRestorePoint` returns a string.


# NOTES


        To run a `Get-ComputerRestorePoint` command on Windows Vista and later versions of Windows, open
        PowerShell with the Run as administrator option.

        `Get-ComputerRestorePoint` uses the WMI SystemRestore class.

# EXAMPLES

    ----------- Example 1: Get all system restore points -----------

    Get-ComputerRestorePoint

    CreationTime           Description                    SequenceNumber    EventType
    RestorePointType
    ------------           -----------                    --------------    ---------
    ----------------
    7/30/2019 09:17:24     Windows Update                 4                 BEGIN_SYSTEM_C... 17
    8/5/2019  08:15:37     Installed PowerShell 7-prev... 5                 BEGIN_SYSTEM_C...
    APPLICATION_INSTALL
    8/7/2019  12:56:45     Installed PowerShell 6-x64     6                 BEGIN_SYSTEM_C...
    APPLICATION_INSTALL


    ----------- Example 2: Get specific sequence numbers -----------

    Get-ComputerRestorePoint -RestorePoint 4, 5

    CreationTime           Description                    SequenceNumber    EventType
    RestorePointType
    ------------           -----------                    --------------    ---------
    ----------------
    7/30/2019 09:17:24     Windows Update                 4                 BEGIN_SYSTEM_C... 17
    8/5/2019  08:15:37     Installed PowerShell 7-prev... 5                 BEGIN_SYSTEM_C...
    APPLICATION_INSTALL

    `Get-ComputerRestorePoint` uses the RestorePoint parameter to specify a comma-separated array of
    sequence numbers.
    ------ Example 3: Display the status of a system restore ------

    Get-ComputerRestorePoint -LastStatus

    The last attempt to restore the computer failed.

    `Get-ComputerRestorePoint` uses the LastStatus parameter to display the result of the most recent
    system restore.
    --- Example 4: Use an expression to convert the CreationTime ---

    $date = @{Label="Date"; Expression={$_.ConvertToDateTime($_.CreationTime)}}
    Get-ComputerRestorePoint | Select-Object -Property SequenceNumber, $date, Description

    SequenceNumber   Date                 Description
    --------------   ----                 -----------
                 4   7/30/2019 09:17:24   Windows Update
                 5   8/5/2019  08:15:37   Installed PowerShell 7-preview-x64
                 6   8/7/2019  12:56:45   Installed PowerShell 6-x64

    The `$date` variable stores a hash table with the expression that uses the ConvertToDateTime method.
    The expression converts the CreationTime property's value from a WMI string to a DateTime object.

    `Get-ComputerRestorePoint` sends the system restore point objects down the pipeline. `Select-Object`
    uses the Property parameter to specify the properties to display. For each object in the pipeline,
    the expression in `$date` converts the CreationTime and outputs the result in the Date property.
    ------ Example 5: Use a property to get a sequence number ------

    ((Get-ComputerRestorePoint).SequenceNumber)[-1]

    6

    `Get-ComputerRestorePoint` uses the SequenceNumber property with an array index. The array index of
    `-1` gets the most recent sequence number in the array.

# RELATED LINKS
[https://docs.microsoft.com/powershell/module/microsoft.powershell.management/get-computerrestorepoint?view=powershell-5.1&WT.mc_id=ps-gethelp](URL "Online Version:")