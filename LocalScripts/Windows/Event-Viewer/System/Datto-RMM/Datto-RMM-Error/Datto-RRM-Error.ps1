#Get the first 25 Datto RMM errors.
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    ProviderName = 'Service Control Manager'
    Level = '2'
    ID = '7024'
} | Select-Object -First 25 | Format-List