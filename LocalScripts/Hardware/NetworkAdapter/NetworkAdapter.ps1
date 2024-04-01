#NetworkAdapter
$NetworkAdapter = Get-CimInstance CIM_NetworkAdapter | FL

Write-Host "Network Adapter"`r

    $NetworkAdapter | Format-Table