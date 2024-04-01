


#Gets the first 25 disk warnings.
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    ProviderName = 'Disk'
    Level = '3'
} | Select-Object -First 25 | Format-List




