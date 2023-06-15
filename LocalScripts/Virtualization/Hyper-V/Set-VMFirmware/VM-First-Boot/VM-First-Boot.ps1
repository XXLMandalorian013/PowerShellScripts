$VMName = "Win10VM-Test-4"

Set-VMFirmware -VMName "$VMName" -FirstBootDevice $(Get-VMDvdDrive -VMName "$VMName")