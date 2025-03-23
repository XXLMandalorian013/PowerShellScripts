Write-Verbose -Message "Checking Each Nic's NetBios setting...Please wait..." -Verbose
Get-CimInstance -ClassName 'Win32_NetworkAdapterConfiguration' | Select-Object ServiceName, Description, TcpipNetbiosOptions
Write-Verbose -Message "TcpipNetbiosOptions Vaules: 0=Default 1=Enabled 2=Disabled. No Vaulue=Not Active Nic" -Verbose