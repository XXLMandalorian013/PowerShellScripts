# NAME
    Checkpoint-Computer

# SYNOPSIS
    Creates a system restore point on the local computer.


# SYNTAX
    Checkpoint-Computer [-Description] <System.String> [[-RestorePointType] {APPLICATION_INSTALL |
    APPLICATION_UNINSTALL | DEVICE_DRIVER_INSTALL | MODIFY_SETTINGS | CANCELLED_OPERATION}]
    [<CommonParameters>]


# DESCRIPTION
    The `Checkpoint-Computer` cmdlet creates a system restore point on the local computer.

    System restore points and the `Checkpoint-Computer` cmdlet are supported only on client operating
    systems, such as Windows 8, Windows 7, Windows Vista, and Windows XP.

    Beginning in Windows 8, `Checkpoint-Computer` cannot create more than one checkpoint each day.


# PARAMETERS
    -Description <System.String>
        Specifies a descriptive name for the restore point. This parameter is required.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -RestorePointType <System.String>
        Specifies the type of restore point. The default is APPLICATION_INSTALL.

        The acceptable values for this parameter are:

        - APPLICATION_INSTALL

        - APPLICATION_UNINSTALL

        - DEVICE_DRIVER_INSTALL

        - MODIFY_SETTINGS

        - CANCELLED_OPERATION

        Required?                    false
        Position?                    1
        Default value                None
        Accept pipeline input?       False
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

# INPUTS
    None
        You cannot pipe objects to `Checkpoint-Computer`.


# OUTPUTS
    None
        This cmdlet does not generate any output.


# NOTES

 1. CMDlet does not work in 7.X.X.
        
 2. A (Win7) File backup creates a restore point in tandeum so you may see,

 WARNING: A new system restore point cannot be created because one has already been created within the past 1440
 minutes. The frequency of restore point creation can be changed by creating the DWORD valuel
 'SystemRestorePointCreationFrequency' under the registry key 'HKLM\Software\Microsoft\Windows
 NT\CurrentVersion\SystemRestore'. The value of this registry key indicates the necessary time interval (in minutes)
 between two restore point creation. The default value is 1440 minutes (24 hours).

        - This cmdlet uses the CreateRestorePoint method of the SystemRestore class with a
        BEGIN_SYSTEM_CHANGE event. - Beginning in Windows 8, `Checkpoint-Computer` cannot create more
        than one system restore point each day. If you try to create a new restore point before the
        24-hour period has elapsed, Windows PowerShell generates the following error:

        

    ----------- Example 1: Create a system restore point -----------

    Checkpoint-Computer -Description "Install MyApp"

    This command creates a system restore point called Install MyApp. It uses the default
    APPLICATION_INSTALL restore point type.
    --- Example 2: Create a system MODIFY_SETTINGS restore point ---

    Checkpoint-Computer -Description "ChangeNetSettings" -RestorePointType MODIFY_SETTINGS

    This command creates a MODIFY_SETTINGS system restore point called "ChangeNetSettings".

# RELATED LINKS
[https://docs.microsoft.com/powershell/module/microsoft.powershell.management/checkpoint-computer?view=powershell-5.1&WT.mc_id=ps-gethelp](URL "Online Version:")
