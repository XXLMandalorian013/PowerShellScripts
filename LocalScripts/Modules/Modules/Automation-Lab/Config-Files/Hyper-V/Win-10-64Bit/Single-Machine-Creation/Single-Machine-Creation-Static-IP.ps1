<#ReadMe

Title
    
.SYNOPSIS

Adds a file name extension to a supplied name.


.DESCRIPTION
        
Adds a file name extension to a supplied name.  
    
    
.Notes

Notes here.
    

.PARAMETER Name
        
Specifies the file name.

    
.PARAMETER Extension
        
Specifies the extension. "Txt" is the default.


.INPUTS
        
None. You cannot pipe objects to Add-Extension.


.OUTPUTS
        
System.String. Add-Extension returns a string with the extension or file name.


.EXAMPLE
        
PS> extension "File" "doc"
File.doc


.LINK
        
[WinGet Install Online Version](https://learn.microsoft.com/en-us/windows/package-manager/winget/install) 

#>

#Region Start-Script

#Global Variables

$global:ScriptAuthor = "DAM"

$global:ModifiedDate = "2023-05-10"

$global:ScriptName = "AutomatedLab Single-Machine-Creation.ps1"

$global:ModuleName = 'AutomatedLab'

#Checks if the terminal is runing as admin/elevated.
if(-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {

    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."  
}

#Writes to the terminal with this script general info.
function Write-ScriptBoilerplate {
    try{

        $ScriptBoilerplate = "$global:ScriptName script starting...written by $global:ScriptAuthor, last modified on $global:ModifiedDate"

        Write-Verbose -Message "$ScriptBoilerplate" -Verbose

    }catch {
        Throw $Error[0]
    }  
}


#Check for required Module(s).
Function Test-ModulePath {

$global:ModuleName = 'AutomatedLab'

$ModuelsPath = Test-Path -Path "C:\LOCAL\$env:UserName\My Documents\PowerShell\Modules\AutomatedLab"

    Try{
            If($ModuelsPath -contains $global:ModuleName){

            }Else{
            Write-Host "$global:ModuleName module not found, installing..."
            Install-Module -Name AutomatedLab
            }

        }Catch{
        Throw $Error[0]
    }
}

#Import required Module(s).
Function Import-Module {

$ModuleImport = Import-Module -Name $global:ModuleName

    Try{
            $ModuleImport

        }Catch{
        Throw $Error[0]
    }
}

#Config for Automation lab machine.
Function Start-LabConfig {

#Define Lab/VMs iso location. Must point to a iso directly
Get-LabAvailableOperatingSystem -Path "I:\ISO-MediaCreation\Win 10\20H2\Windows.iso"

#Name of the lab to be created.
$LabName = 'Win1064BitSingle'

$LabNetworkIp = Read-Host 'Type Network Adapters IP address.'

$UserName = Read-Host 'Type a username for the Config File.'

$Password = Read-Host -AsSecureString 'Type a password for the Config File.'

$MachineName = Read-Host 'Type the machines name you wish to use, ie Win10ProVM-Test-1.'

$MachineRAM = Read-Host 'Type the machines allocation of RAM ie 8GB, 16GB, 24GB. Be sure to add GB after the number.'

$MachineIP = Read-Host 'Type machine IP address ie 192.168.70.12.'

$WinOSVer = Read-Host 'Type the iso you wish to use, ie Windows 10 Pro.'

    Try{

    #createss an empty lab template and define where the lab XML files and the VMs will be stored
    New-LabDefinition -Name $LabName -DefaultVirtualizationEngine HyperV

    #make the network definition
    Add-LabVirtualNetworkDefinition -Name $LabName -AddressSpace "$LabNetworkIp"

    Set-LabInstallationCredential -Username "$UserName" -Password "$Password"

    #Our one and only machine with nothing on it
    Add-LabMachineDefinition -Name $MachineName -Memory $MachineRAM -Network $LabName -IpAddress "$MachineIP" -OperatingSystem "$WinOSVer"

    Install-Lab

    Show-LabDeploymentSummary -Detailed

    }Catch{
    Throw $Error[0]
    
    }
}

#Writes to the terminal with this script general info.
Write-ScriptBoilerplate

#Check for required Module(s).
Test-ModulePath

#Import required Module(s).
Import-Module

#Config for Automation lab machine.
Start-LabConfig

#EndRegion
