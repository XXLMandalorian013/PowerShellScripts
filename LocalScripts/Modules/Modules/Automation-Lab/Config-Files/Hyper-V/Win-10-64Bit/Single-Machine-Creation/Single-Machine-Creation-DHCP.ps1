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

#Lab Sources location.
$global:LabSources = 'I:\LabSources\ISOs'

#VMs install location.
$global:VmPath = 'I:'



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

$ModuelsPath = Test-Path -Path "C:\LOCAL\$env:UserName\My Documents\PowerShell\Modules\AutomatedLab"

    Try{
            If($ModuelsPath -contains $global:ModuleName){

            }Else{
            Write-Host "$global:ModuleName module not found, installing..."
            Install-Module -Name "$global:ModuleName"
            }

        }Catch{
        Throw $Error[0]
    }
}

#Config for Automation lab machine.
Function Start-LabConfig {

    Try{

        #Defines the Labs location. Cannot have the LabSource folder on multiple drives.
        New-LabSourcesFolder -DriveLetter "$global:LabSources"

        New-LabDefinition -Name Win10 -DefaultVirtualizationEngine HyperV -VmPath $global:VmPath

        Add-LabVirtualNetworkDefinition -Name 'New Virtual Switch' -HyperVProperties @{ SwitchType = 'External'; AdapterName = 'Ethernet' }
        
        Add-LabMachineDefinition -Name 'Win10VMTest8' -Memory '8GB' -OperatingSystem 'Windows 10 Pro' -Network 'New Virtual Switch'
        
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





$labSources = ‘E:\LabSources’ #here are the lab sources

$vmDrive = ‘D:’ #this is the drive where to create the VMs

$labName = ‘FirstLab’ #the name of the lab, virtual machine folder and network switch

#create the folder path for the lab using Join-Path

$labPath = Join-Path -Path $vmDrive -ChildPath $labName


New-LabDefinition -Path $labPath -VmPath $labPath -Name $labName -ReferenceDiskSizeInGB 60

#define the network

Add-LabVirtualNetworkDefinition -Name $labNetworkName -IpAddress 192.168.81.1 -PrefixLength 24

#these images are used to install the machines

Add-LabIsoImageDefinition -Name Server2012R2 -Path $labSources\ISOs\ en_windows_server_2012_r2_with_update_x64_dvd_4065220.iso

–IsOperatingSystem


Add-LabMachineDefinition -Name S1DC1 `

    -MemoryInMb 512 `

    -Network $labNetworkName `

    -IpAddress 192.168.81.10 `

    -DnsServer1 192.168.81.10 `

    -DomainName test1.net `

    -IsDomainJoined `

    -Roles $role `

    -InstallationUserCredential $installationCredential `

    -ToolsPath $labSources\Tools `

    -OperatingSystem ‘Windows Server 2012 R2 SERVERDATACENTER’







    New-LabDefinition -Name $labName -DefaultVirtualizationEngine HyperV -VmPath D:\AutomatedLab-VMs


