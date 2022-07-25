$Email = Read-Host "Type an email adress ie user@domain.com"

Get-EXOMobileDeviceStatistics -Mailbox $Email | Select-Object 'Status', 'ClientType', 'ClientVersion', 'DeviceFriendlyName', 'DeviceType', 'DeviceOS', 'LastSyncAttemptTime', 'LastSuccessSync' | Format-List