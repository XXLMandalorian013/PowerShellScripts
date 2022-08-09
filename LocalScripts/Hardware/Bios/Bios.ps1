#Bios
$Bios = Get-CimInstance -Class CIM_BIOSElement |Select-Object Manufacturer,Name,SMBIOSBIOSVersion

Write-Host "Bios"`r

    $Bios | Format-List