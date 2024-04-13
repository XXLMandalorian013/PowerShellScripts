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

VERBOSE: Power-Toys-.79-64Bit-Machine.ps1 script starting...written by DAM 2024-03-17, last modified Never
VERBOSE: The terminal is running as an Administrator...Continuing script...
Exception:
Line |
  15 |          Throw "$InstallerName is already installed..."
     |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | 7z2301-x64.msi is already installed...

or

VERBOSE: 7-Zip-64Bit-23.01.ps1 script starting...written by DAM 2024-03-17, last modified Never
VERBOSE: The terminal is running as an Administrator...Continuing script...
VERBOSE: The PowerSHell version is grater than 3.0...Continuing script...
VERBOSE: Downloading 7z2301-x64.msi...
VERBOSE: Installing 7z2301-x64.msi
VERBOSE: 7z2301-x64.msi Installed!

.LINK

[Write-Verbose](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-verbose?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.4)

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3)

[about_Try_Catch_Finally](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.3)

[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3)

[about_Operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)

[about_Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.3)

[about_Do](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.3)

[Start-Process](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-7.4)

[msi exec](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/msiexec)

[7-Zip DL page](https://www.7-zip.org/download.html)

[7-Zip Switchs](https://7-zip.org/faq.html)

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
                robocopy $OneDrivePath /e /zb "$FinalDestinationPath" *.* /copyall /log+:$FinalDestinationPath\RoboCopyLog.log /v /ts /fp /eta /x
                Write-Verbose -Message "OneDrive backup has finished!" -Verbose
                Get-ChildItem -Path "$FinalDestinationPath"
            }else {
                Write-Verbose -Message "Backup folder found "$FinalDestinationPath"...the backup has already ran today...exiting..." -Verbose
                Exit
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

