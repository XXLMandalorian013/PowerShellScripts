#Get the first 25 system.
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    ProviderName = 'EventLog'
    Level = '4'
    ID = '6013'
} | Select-Object -First 25 | Format-List