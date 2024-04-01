Get-CimInstance -Class 'Win32_UserProfile' | Select-Object 'LastUseTime', 'LocalPath', 'SID'

$UserAcct = Read-Host 'Please see above and type the user name you wish to remove.'

Get-CimInstance -Class 'Win32_UserProfile' | Where-Object { $_.LocalPath.split('\')[-1] -eq "$UserAcct" } | Remove-CimInstance