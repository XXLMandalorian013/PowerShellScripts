    #ReadMe
<#

New-VHDX.ps1

.DESCRIPTION

Creates a new VHDX.  

.Notes

Notes here.
The disk will need to be mounted to a host if computer name was not specifed.

.INPUTS
        
Adjust global var and splatting as needed.

.OUTPUTS
        
System.String.

PS C:\Users\UserName> New-VHDCreation
Virtual Hard Disk Creation [99%]

.LINK
        
[New-VHD](https://learn.microsoft.com/en-us/powershell/module/hyper-v/new-vhd?view=windowsserver2022-ps) 

#>

#Region Start-Script

#Global Variables

#The vhd(x)'s name. Note, the vhd(x) needs its type specifed, so make sure denote .vhd or .vhdx at the end.
$Global:VHDName = 'VHDX-Test-1.vhdx'

#Where the vhd(x) will be stored. Note, the vhd(x) needs its type specifed, so make sure denote .vhd or .vhdx at the end.
$Global:Path = "E:\Files\Hyper-V\VHD\VHDXs\$Global:VHDName"

#The size of the vhd(x). Change to MB, GB or TB as needed.
$Global:SizeByte = 80MB

#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    $ScriptName = "New-VHDX.ps1"

    $ScriptAuthor = "DAM"

    $ModifiedDate = "2023-08-13"

    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate"
    
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}

Start-ScriptBoilerplate

#New-VVHD's hashtable splatting for it paramiters.
$NewVMDParams = @{

    #Where the VM will be stored.
    Path = $Global:Path

    #The size of the vhd(x).
    SizeByte = $Global:SizeByte
    
    #Fixed volume takes up all the space at once, Dynamic only uses what is written to it, up to its specified max SizeBytes
    Fixed = $True

}

#Create a new VHD based off the splatting peramiters above.
function New-VHDCreation {
    
    New-VHD @NewVMDParams
    
}

New-VHDCreation

#EndRegion

