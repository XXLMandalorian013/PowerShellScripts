$Global:VMName = "Win10VM-Test-4"

Set-VMFirmware -VMName "$Global:VMName" -FirstBootDevice $(Get-VMDvdDrive -VMName "$Global:VMName")