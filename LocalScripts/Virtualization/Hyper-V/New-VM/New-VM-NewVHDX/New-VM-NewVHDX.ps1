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

[New-VM](https://learn.microsoft.com/en-us/powershell/module/hyper-v/new-vm?view=windowsserver2022-ps&source=docs)

[Add-VMDvdDrive](https://learn.microsoft.com/en-us/powershell/module/hyper-v/add-vmdvddrive?view=windowsserver2022-ps)

[Hyper-V Virtual Machine Connection](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/learn-more/hyper-v-virtual-machine-connect)

#>

#Region Start-Script

#VM Global Variables

#VM's Name
$Global:VMName = "Win10VM-Test-3"

#Where the VM will be stored.
$Global:Path = 'I:\HyperV\VMs\'

#Bios/UEFI
$Global:Generation = '2'

#Memory size in bytes.
$Global:MemorySize = '17179869184'

#Virtual Switch
$Global:SwitchName = 'New Virtual Switch'

#VHD Size in bytes.
$Global:VHDSize = '128849018880'

#VHD Path
$Global:VHDPath = "I:\HyperV\VMs\$VMName\Virtual Hard Disks.vhdx"

#Specifiess where the VM should try to boot from.
$Global:BootDevice = 'VHD'

#Specifies where the ISO is located.
$Global:ISOPath = "I:\ISO-MediaCreation\Win 10\22H2\Win1022H2.iso"

#Specifies what server/PC the VM's are hoosted on.
$Global:ServerName = 'PCName-007'

#Creates new VM.
New-VM -Name $Global:VMName -Path $Global:Path -Generation $Global:Generation -MemoryStartupBytes $Global:MemorySize -SwitchName "$Global:SwitchName" -NewVHDPath $Global:VHDPath -NewVHDSizeBytes $Global:VHDSize

#As this script creates a VHDX, you must add a virtual disk drive and provies the .iso path to run to install an OS. 
Add-VMDvdDrive -VMName "$Global:VMName" -Path "$Global:ISOPath"

#Starts the VM.
Start-VM -Name $Global:VMName

#Connects to the VM's GUI.
vmconnect.exe $Global:ServerName $Global:VMName

#EndRegion


