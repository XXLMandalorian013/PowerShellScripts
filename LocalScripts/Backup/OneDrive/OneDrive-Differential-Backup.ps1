#ReadMe
<#

7-Zip-64Bit-23.01.ps1

.SYNOPSIS

Installs 7-Zip 64Bit verstion 23.01.

.Notes

An elivated terminal and PS Ver 3.0 or higher is required.

.INPUTS

None.

.OUTPUTS

System.String,

VERBOSE: OneDrive-Backup.ps1 script starting...written by DAM 2024-04-13, last modified Never.
VERBOSE: The terminal is running as an Administrator...Continuing script...
VERBOSE: Script starting...
VERBOSE: No current backup folder found...Creating a backup folder C:\Test\04-13-2024.

    Directory: C:\Test

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----           4/13/2024  3:12 PM                04-13-2024
VERBOSE: Copying files...please wait.

 Log File : C:\Test\04-13-2024\RoboCopyLog.log
VERBOSE: OneDrive backup has finished!

    Directory: C:\Test\04-13-2024

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----           5/19/2023  6:15 AM                Apps
d----           11/4/2022  3:43 PM                Backups
d-r--          11/13/2022  1:44 PM                Desktop
d-r--           3/16/2024  3:33 PM                Documents
d----           11/4/2022  3:43 PM                Email attachments
d----           8/13/2023  8:13 AM                Microsoft Edge Drop Files
d----           11/4/2022  3:43 PM                OneNoteBooks
d-r--           12/2/2022  2:53 PM                Pictures
d----           11/4/2022  3:43 PM                Public
d----            4/5/2023  5:12 PM                Shared
d----          11/13/2022  1:47 PM                Videos
-a---           4/13/2024 12:12 PM           1140 Personal Vault.lnk
-a---           4/13/2024  3:12 PM          19456 RoboCopyLog.log
VERBOSE: This script has finished running...

PS C:\Users\XXLMandalorian> #EndRegion

or

VERBOSE: Script starting...
VERBOSE: A positional parameter cannot be found that accepts argument 'C:\Test\04-13-2024...the backup has already ran today...exiting...'.[0]
VERBOSE: This script has finished running...

.LINK

[Write-Verbose](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-verbose?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.4)

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3)

[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3)

[about_Operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)

#>

#Script
#Region Start-Script
#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    param (
        $ScriptName = "OneDrive-Backup.ps1",
        $ScriptAuthor = "DAM",
        $WrittenDate = "2024-04-13",
        $ModifiedDate = "Never",
        $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor $WrittenDate, last modified $ModifiedDate."
    )
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}
#Checks to see if the terminal is running as an administrator. This is required for RoboCopy.
function Test-TerminalElevation {
    #Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
        Exit
    }else {
        Write-Verbose -Message "The terminal is running as an Administrator...Continuing script..." -Verbose
    }
}
#Downloads all OneDrive files to a specified location.
function Backup-OneDrive {
    param (
        $OneDrivePath = "C:\Users\$env:UserName\OneDrive",
        $DestinationPath = "C:\Test"
    )
    begin {
        Write-Verbose -Message "Script starting..." -Verbose
        try {
            #Gets the current date.
            $CurrentDate = Get-Date -Format "MM-dd-yyyy"
            #Creates a dir if it does not exsist
            $TestPath1 = Test-Path -Path "$DestinationPath\$CurrentDate"
            #Destionation Path for download.
            $FinalDestinationPath = "$DestinationPath\$CurrentDate"
            if ("$TestPath1" -ne "True") {
                Write-Verbose -Message "No current backup folder found...Creating a backup folder $FinalDestinationPath." -Verbose
                New-Item -Path "$FinalDestinationPath" -ItemType "Directory"
                Write-Verbose -Message "Copying files...please wait." -Verbose
                robocopy $OneDrivePath /e /zb /xo "$FinalDestinationPath" *.* /copyall /log+:$FinalDestinationPath\RoboCopyLog.log /v /ts /fp /eta /x
                Write-Verbose -Message "OneDrive backup has finished!" -Verbose
                Get-ChildItem -Path "$FinalDestinationPath"
            }else {
                Write-Verbose -Message "Backup folder found "$FinalDestinationPath"...the backup has already ran today...exiting..." -Verbose
            }
        }catch {
            Write-Verbose -Message "$Error[0]" -Verbose
        }
    }end {
        Write-Verbose -Message "This script has finished running..." -Verbose
    }
}
#Letting the user know what is starting.
Start-ScriptBoilerplate
#Checks to see if the terminal is running as an administrator. This is required for RoboCopy.
Test-TerminalElevation
#Downloads all OneDrive files to a specified location.
Backup-OneDrive
#EndRegion

