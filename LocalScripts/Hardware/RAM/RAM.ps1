$RAM = Get-CimInstance CIM_PhysicalMemory | Select-Object Tag,DeviceLocator,Manufacturer,PartNumber,SerialNumber,FormFactor,DataWidth,Speed,ConfiguredClockSpeed,ConfiguredVoltage

$RAM | Format-table

$RAMTotal = (Get-CimInstance CIM_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb

Write-Host "Total RAM $RAMTotal GB "
