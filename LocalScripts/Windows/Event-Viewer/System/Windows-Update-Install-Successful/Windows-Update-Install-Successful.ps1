#Get the first 25 Windows updates that have installed successfully.
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    ProviderName = 'Microsoft-Windows-WindowsUpdateClient'
    Level = '4'
    ID = '44'
} | Select-Object -First 25 | Format-List