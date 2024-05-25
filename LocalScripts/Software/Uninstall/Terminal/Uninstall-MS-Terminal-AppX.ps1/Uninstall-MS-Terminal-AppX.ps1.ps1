#ReadMe
<#
Uninstall-MS-Terminal-AppX.ps1.ps1
.SYNOPSIS
Adds a file name extension to a supplied name.
.OUTPUTS
System.String.
VERBOSE: Uninstall-MS-Terminal-AppX.ps1.ps1 script starting...written by DAM 2024-05-25, last modified Never.
VERBOSE: The terminal is running as an Administrator...Continuing script...
VERBOSE: Microsoft.WindowsTerminal found...
VERBOSE: Removing Microsoft.WindowsTerminal...
VERBOSE: Microsoft.WindowsTerminal removed...
.EXAMPLE
#>
#Region Start-Script
#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    param (
        $ScriptName = "Uninstall-MS-Terminal-AppX.ps1.ps1",
        $ScriptAuthor = "DAM",
        $WrittenDate = "2024-05-25",
        $ModifiedDate = "Never",
        $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor $WrittenDate, last modified $ModifiedDate."
    )
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}
#Checks to see if the terminal is running as an administrator.
function Test-TerminalElevation {
    #Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
    }else {
        Write-Verbose -Message "The terminal is running as an Administrator...Continuing script..." -Verbose
    }
}
#Removes Manually Installed Terminal
function Remove-AppxPackagez {
    param (
        $PackageName = "Microsoft.WindowsTerminal"
    )
    $GetPackage = Get-AppxPackage -Name "$PackageName"
    $PackageFullName = $GetPackage.PackageFullName
    Write-Verbose -Message "$PackageName found..." -Verbose
    Write-Verbose -Message "Removing $PackageName..." -Verbose
    Remove-AppxPackage -Package $PackageFullName
    Write-Verbose -Message "$PackageName removed..." -Verbose
}
#Function Calls
$Functions = @(
    #Letting the user know what is starting.
    Start-ScriptBoilerplate
    #Checks to see if the terminal is running as an administrator.
    Test-TerminalElevation
    #Removes Manually Installed Terminal
    Remove-AppxPackagez
)
$Functions
#EndRegion