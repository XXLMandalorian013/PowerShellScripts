#ReadMe
<#

New-VM-NewVHDX

.DESCRIPTION

Create a new virtual machine with a new VDHX based of global peramiters.

.INPUTS

None.

.OUTPUTS

System.String.

Name           State CPUUsage(%) MemoryAssigned(M) Uptime   Status             Version
----           ----- ----------- ----------------- ------   ------             -------
Win10VM-Test-3 Off   0           0                 00:00:00 Operating normally 11.0

.LINK

[about_Scopes](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes?view=powershell-7.3)

[about_Splatting](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting?view=powershell-7.3)

[New-VM](https://learn.microsoft.com/en-us/powershell/module/hyper-v/new-vm?view=windowsserver2022-ps&source=docs)

[Add-VMDvdDrive](https://learn.microsoft.com/en-us/powershell/module/hyper-v/add-vmdvddrive?view=windowsserver2022-ps)

[Hyper-V Virtual Machine Connection](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/learn-more/hyper-v-virtual-machine-connect)

#>

#Region Start-Script

#Global Variables

#VM's Name
$Global:VMName = "Win10VM-Test-4"

#Where the VM will be stored.
$Global:Path = 'I:\HyperV\VMs\'

#Specifies what server/PC the VM's are hoosted on.
$Global:ServerName = 'CX3700-06'

#New-VM's hashtable splatting for it paramiters.
$NewVMParams = @{

    #VM's Name
    Name = "$Global:VMName"

    #Where the VM will be stored.
    Path = "$Global:Path"

    #Bios/UEFI
    Generation = '2'

    #Memory size in bytes.
    MemoryStartupBytes = '17179869184'

    #Virtual Switch
    SwitchName = 'New Virtual Switch'

    #VHD Path
    NewVHDPath = "I:\HyperV\VMs\$VMName\Virtual Hard Disks.vhdx"

    #VHD Size in bytes.
    NewVHDSizeBytes = '128849018880'

}

#Add-VMDvdDrive's hashtable splatting for it paramiters.
$VMDVDDrive = @{

    #VM's Name
    VMName = "$Global:VMName"

    #Specifies where the ISO is located.
    Path = "I:\ISO-MediaCreation\Win 10\22H2\Win1022H2.iso"
}

$StartVM = @{

    #VM's Name
    Name = "$Global:VMName"

}

#As this script creates a VHDX, you must add a virtual disk drive and provies the .iso path to run to install an OS.
New-VM @NewVMParams

#As this script creates a VHDX, you must add a virtual disk drive and provies the .iso path to run to install an OS. 
Add-VMDvdDrive @VMDVDDrive

#Starts the VM.
Start-VM @StartVM

#Connects to the VM's GUI. Not able to splat vmconnect.exe due to its syntax.
vmconnect.exe $Global:ServerName $Global:VMName

#EndRegion


