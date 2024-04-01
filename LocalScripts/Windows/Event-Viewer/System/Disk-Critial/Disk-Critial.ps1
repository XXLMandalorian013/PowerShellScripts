
#Get the first 25 disk critials.
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    ProviderName = 'Disk'
    Level = '1'
} | Select-Object -First 25 | Format-List


