    #ReadMe
<#

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

#Script

$ScriptName = 'Automation Lab Single Machine Creation'



Write-Host "$ScriptName script starting...Written by DAM on 2023-02-18"



#Check for required Module(s).

Function Module-Check {

$ModuleName = 'AutomatedLab'

$ModuelsPath = Test-Path -Path "C:\Users\$env:UserName\Documents\PowerShell\Modules\AutomatedLab"

    Try{
            If($ModuelsPath -contains $ModuleName){

            }Else{
            Write-Host "$ModuleName module not found, installing..."
            Install-Module -Name AutomatedLab
            }

        }Catch{
        Throw $Error[0]
    }
}


#Import required Module(s).

Function Module-Import {

$ModuleName = 'AutomatedLab'

$ModuleImport = Import-Module -Name AutomatedLab

    Try{
            $ModuleImport

        }Catch{
        Throw $Error[0]
    }
}


#Config for Automation lab machine.

Function Lab-Config {

$LabName = 'Win10-64Bit-Single'

$LabNetworkIp = Read-Host -AsSecureString 'Type Network Adapters IP address.'

$UserName = Read-Host 'Type a username for the Config File.'

$Password = Read-Host -AsSecureString 'Type a password for the Config File.'

$MachineName = Read-Host 'Type the machines name you wish to use, ie Win10ProMachine.'

$MachineRAM = Read-Host 'Type the machines allocation of RAM ie 8GB, 16GB, 24GB. Be sure to add GB after the number.'

$MachineIP = Read-Host -AsSecureString 'Type machine IP address ie 192.168.70.12.'

$WinOSVer = Read-Host 'Type the iso you wish to use, ie Windows 10 Pro.'


    Try{

    #create an empty lab template and define where the lab XML files and the VMs will be stored
    New-LabDefinition -Name $LabName -DefaultVirtualizationEngine HyperV

    #make the network definition
    Add-LabVirtualNetworkDefinition -Name $LabName -AddressSpace "$LabNetworkIp"

    Set-LabInstallationCredential -Username "$UserName" -Password "$Password"

    #Our one and only machine with nothing on it
    Add-LabMachineDefinition -Name TestClient1 -Memory $MachineRAM -Network $LabName -IpAddress "$MachineIP" -OperatingSystem "$WinOSVer"

    Install-Lab

    Show-LabDeploymentSummary -Detailed

    }Catch{
    Throw $Error[0]
    
    }
}


#Check for required Module(s).

Module-Check

#Import required Module(s).

Module-Import

#Config for Automation lab machine.

Lab-Config