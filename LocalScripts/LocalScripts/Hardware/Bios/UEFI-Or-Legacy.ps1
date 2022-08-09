#Check for UEFI or Legacy Bios

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-computerinfo?view=powershell-7.2

Write-Host 'UEFI will show as UEFI, if Legacy/MBR Bios then it will just say Bios.'

Get-ComputerInfo | Select-Object 'BiosFirmwareType'