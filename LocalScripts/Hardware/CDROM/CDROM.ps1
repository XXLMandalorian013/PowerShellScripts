#CD Rom Drive
$CDRomDrive = Get-CimInstance -Class CIM_CDROMDrive

Write-Host "CD Rom Drive"`r

    $CDRomDrive | Format-List