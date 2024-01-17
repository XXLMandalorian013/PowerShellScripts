    #ReadMe
<#

Get-BitLockerDrivesAndRecoveryPassword.ps1

.DESCRIPTION

Gets Bitlocker enabled drives and their KeyProtectorType, KeyProtectorId, and RecoveryPassword.

.OUTPUTS

System.String.

ComputerName: ComputerName

VolumeType      Mount CapacityGB VolumeStatus           Encryption KeyProtector              AutoUnlock Protection
                Point                                   Percentage                           Enabled    Status
----------      ----- ---------- ------------           ---------- ------------              ---------- ----------
OperatingSystem C:        953.14 FullyEncrypted         100        {RecoveryPassword, Tpm}              On

KeyProtectorType : RecoveryPassword
KeyProtectorId   : {2846A5FB-F6A0-4132-B9}
RecoveryPassword : 23423-234234232342-2342-2342342-324234


KeyProtectorType : Tpm
KeyProtectorId   : {12312-123123-213-123123}
RecoveryPassword :

.LINK

[functions](https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/09-functions?view=powershell-7.4)

[If Else](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.3)

[about Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.4)

[Get-BitLockerVolume](https://learn.microsoft.com/en-us/powershell/module/bitlocker/get-bitlockervolume?view=windowsserver2022-ps)

[Select-Object](https://learn.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Utility/Select-Object?view=powershell-7.4)

#>

#Region Start-Script
#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    $ScriptName = "Get-BitLockerDrivesAndRecoveryPassword.ps1"

    $ScriptAuthor = "DAM"

    $ModifiedDate = "2024-01-17"

    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate"
    
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}
#Checks if the terminal is runing as admin/elevated as Get-BitLockerVolume requires it.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
}
#Gets Bitlocker enabled drives and their KeyProtectorType, KeyProtectorId, andRecoveryPassword.
function Get-BitLockerDrivesAndRecoveryPassword {
    #Puts Get-BitLockerVolume into a varaible.
    $BitlockerVolumes = Get-BitLockerVolume
    Get-BitLockerVolume 
    #Grabs the BL KeyProtectorType,KeyProtectorId,RecoveryPassword.
    $BitlockerVolumes | Select-Object -ExpandProperty KeyProtector | Select-Object -Property 'KeyProtectorType','KeyProtectorId','RecoveryPassword'
}
#Letting the user know what is starting.
Start-ScriptBoilerplate
#Gets Bitlocker enabled drives and their KeyProtectorType, KeyProtectorId, andRecoveryPassword.
Get-BitLockerDrivesAndRecoveryPassword
#EndRegion

