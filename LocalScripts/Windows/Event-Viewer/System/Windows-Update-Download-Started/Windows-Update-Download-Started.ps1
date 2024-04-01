#Get the first 25 Windows updates that have started installing.
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    ProviderName = 'Microsoft-Windows-WindowsUpdateClient'
    Level = '4'
    ID = '19'
} | Select-Object -First 25 | Format-List