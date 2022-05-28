#CPU
$CPU = Get-CimInstance -Class CIM_Processor |Select-Object Status,SocketDesignation,Manufacturer,Name,NumberOfCores,NumberOfEnabledCore,NumberOfLogicalProcessors,ThreadCount,CurrentClockSpeed,MaxClockSpeed,L2CacheSize,L3CacheSize,VoltageCaps

Write-Host "CPU"`r

    $CPU | Format-List