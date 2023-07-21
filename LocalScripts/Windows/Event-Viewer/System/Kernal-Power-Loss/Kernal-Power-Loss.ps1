
#Get the first 25 kernal power losses.
Get-WinEvent -FilterHashtable @{
    LogName = 'System'
    ProviderName = 'Microsoft-Windows-Kernel-Power'
    Level = '1'
    ID = '41'
} | Select-Object -First 25 | Format-List


