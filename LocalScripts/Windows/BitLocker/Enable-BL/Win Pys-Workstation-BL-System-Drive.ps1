#ReadMe
<#

Win-Workstation-BitLocker-Enabled.ps1

.DESCRIPTION

Enables BitLocker if possible on a physical workstation.

#>
#Region Start-Script
#Boilerplate.
function Start-ScriptBoilerplate {
    $ScriptName = "Win-Workstation-BitLocker-Enabled.ps1"
    $ScriptAuthor = "JPG & DAM"
    $ModifiedDate = "2025-03-18"
    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate"
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}
#Throws if the terminal is not running elevated.
function Test-TerminalElivation {
    #Checks if the terminal is runing as admin/elevated
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
    }
}
# Check if BitLocker is already enabled. If so checks if it can resume the protection that was paused.
# Will disable Bitlocker if BL is enabled but protection is off/paused and enabled when it is can cause the recovery key to be blank.
function Test-BitLockerEnabled {
    $BitLockerVolume = Get-BitLockerVolume | Where-Object {$_.VolumeType -eq "OperatingSystem"}
    if ($BitLockerVolume) {
        Write-Verbose -Message "Checking if BitLocker is enabled on the OS drive"
        if ($BitLockerVolume.VolumeStatus -eq "FullyEncrypted") {
            Write-Verbose -Message "BitLocker is fully enabled on the operating system drive." -Verbose
            if ($BitLockerVolume.ProtectionStatus -eq "On") {
                Throw "BitLocker is enabled and protection is active...ending script."
            } elseif ($BitLockerVolume.ProtectionStatus -eq "Off") {
                Write-Verbose -Message "BitLocker is enabled but protection is paused." -Verbose
                Write-Verbose -Message "Disabling BitLocker Protection." -Verbose
                Disable-BitLocker -MountPoint "$env:SystemDrive"
                Write-Verbose -Message "Successfully resume BitLocker Protection...ending script." -Verbose
                exit 0
            } else {
                Throw "Unknown protection status detected. Ending script."
            }
        } else {
            Write-Verbose -Message "BitLocker is not fully enabled on the operating system drive...continuing." -Verbose
        }
    } else {
        Write-Verbose -Message "No operating system drive found with BitLocker enabled...continuing." -Verbose
    }
}
#Checks to see if its a server, and if so throws.
function Test-OSVersion {
    # Get the operating system information
    $OSInfo = Get-WmiObject -Class Win32_OperatingSystem
    # Check if the OS is a server edition
    if ($OSInfo.Caption -match "Windows Server") {
        Throw "This device is running a Windows Server operating system."
    } else {
        Write-Output "This device is not a server...continuing." -Verbose
    }
}
#Throws if a device is a VM. We don't want to put BitLocker on a VM as it could be apart of an Array using dedupe or be a Zerto backuped device.
function Get-DeviceModel {
    $ComputerSystem = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty 'Model' | Out-String
    if ($ComputerSystem -match "Virtual|VMware|Hyper-V") {
        Throw "This device is a VM: $ComputerSystem...ending script..."
    } else {
        Write-Output "This device is a physical machine: $ComputerSystem...continuing..."
    }
}
#Check if a TPM exsists.
function Test-TPMModule {
    $tpm = Get-TPM
    if ($tpm.TpmPresent) {
        Write-Output "TPM is present...continuing..."
    } else {
        Throw "TPM does not apear present...ending script..."
    }
}
#TMP version check, Bitlocker requires a TPM of 1.2 or higher.
function Test-TPMVersion {
    $tpm = Get-CimInstance -Namespace "Root\CIMv2\Security\MicrosoftTpm" -ClassName Win32_Tpm
    if ($tpm.SpecVersion -ge "1.2") {
        Write-Output "TPM version is greater than or equal to 1.2...continuing..."
    } else {
        Throw "TPM version is less than 1.2...ending script..."
    }
}
#Check if a know incompatable KB is installed.
#Define the list of KBs to check
$KBList = @("KB5040442", "KB5040442", "KB5040431", "KB5040427", "KB5040427", "KB5040448")
function Test-KBInstalled {
    $InstalledKBs = @()
    foreach ($KB in $KBList) {
        $HotFix = Get-HotFix | Where-Object { $_.HotFixID -eq $KB }
        if ($HotFix -ne $null) {
            $InstalledKBs += $KB
        }
    }
    if ($InstalledKBs.Count -gt 0) {
        Write-Output "The following KB(s) are installed: $($InstalledKBs -join ', ')...ending script..."
        Throw "KB(s) installed: $($InstalledKBs -join ', ')."
    } else {
        Write-Output "No problematic KBs found...continuing..."
    }
}
#Enabled BitLocker if the TMP is ready.
#Note the following,
# If you see... Add-TpmProtectorInternal : This key protector cannot be added. Only one key protector of this type is allowed for this drive. (Exception from HRESULT: 0x80310031)
# BitLocker could be paused or the TMP key is deleted but BitLocker is enabled. Renable BitLocker is paused or disabled BitLocker and delete the exsisting TMP key and re-enable Bitlocker.
# Resume BitLocker: Resume-BitLocker $env:SystemDrive | Disable BitLocker: Disable-BitLocker -MountPoint "$env:SystemDrive" & Delete TMP Keys: manage-bde -protectors -delete C:
function Start-BitLocker {
    $TPMStatus = Get-Tpm
    if ($TPMStatus.TPMReady -eq $true) {
        Write-Verbose -Message "The TPM is ready...continuing" -Verbose
        Write-Verbose -Message "Attpemting to Enabling BitLocker on $env:SystemDrive" -Verbose
        #Check is Bitlocker is decrypting.
        $BLStatus = Get-BitlockerVolume
        if ($BLStatus.VolumeStatus -eq "DecryptionInProgress") {
            Throw "Bitlocker is decrypting"
            exit 0
        }else {
            Write-Verbose -Message "Enabling BitLocker on $env:SystemDrive" -Verbose
            #Enable BitLocker
            Enable-BitLocker -MountPoint $env:SystemDrive -UsedSpaceOnly -TpmProtector -ErrorAction Stop
            #Add BitLocker Key Protector
            Add-BitLockerKeyProtector -RecoveryPasswordProtector -MountPoint $env:SystemDrive
            Write-Verbose -Message "Bitlocker Key Protector added successfully" -Verbose
            Write-Verbose -Message "Bitlocker is enabled." -Verbose
        }
    }else {
        Write-Verbose -Message "TPM is not ready for use. Unable to enable BitLocker." -Verbose
        $TPMState
    }
}
#Functions above being called.
Start-ScriptBoilerplate
#Throws if the terminal is not running elevated.
Test-TerminalElivation
# Check if BitLocker is already enabled.
Test-BitLockerEnabled
#Checks to see if its a server, and if so throws.
Test-OSVersion
#Throws if a device is a VM. We don't want to put BitLocker on a VM as it could be apart of an Array using dedupe or be a Zerto backuped device.
Get-DeviceModel
#Check if a TPM exsists.
Test-TPMModule
#TMP version check, Bitlocker requires a TPM of 1.2 or higher.
Test-TPMVersion
#Check if a know incompatable KB is installed.
Test-KBInstalled
#Enabled BitLocker if the TMP is ready.
Start-BitLocker
#EndRegion

