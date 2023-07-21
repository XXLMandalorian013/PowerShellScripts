
#Get the first 25 unexpected shutdown.
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    ProviderName = 'EventLog'
    Level = '2'
    ID = '6008'
} | Select-Object -First 25 | Format-List


