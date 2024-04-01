#Get the first 25 Windows update failure.
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    ProviderName = 'Microsoft-Windows-WindowsUpdateClient'
    Level = '2'
    ID = '20'
} | Select-Object -First 25 | Format-List