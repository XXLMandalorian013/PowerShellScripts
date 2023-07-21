
#Get the first 25 System Disk Errors relating to bad block. "The device, \DeviceHarddisk0\DRO, has a bad block."
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    ProviderName = 'Disk'
    Level = '2'
    ID = '7'
} | Select-Object -First 25 | Format-List


