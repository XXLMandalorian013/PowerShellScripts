$bootuptime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
$CurrentDate = Get-Date
$uptime = $CurrentDate - $bootuptime
$uptime

Get-CimInstance Win32_OperatingSystem | Select-Object LastBootUpTime

