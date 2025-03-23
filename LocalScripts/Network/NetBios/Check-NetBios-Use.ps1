# Get all network interfaces
$networkAdapters = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
foreach ($adapter in $networkAdapters) {
    # Get the IP addresses for each network adapter
    $ipAddresses = (Get-NetIPAddress -InterfaceAlias $adapter.Name -AddressFamily IPv4).IPAddress
    foreach ($ip in $ipAddresses) {
        # Run nbtstat -a for each IP address
        Write-Host "Running nbtstat -a for IP: $ip"
        nbtstat -a $ip
    }
}