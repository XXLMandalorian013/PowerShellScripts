function Get-DeviceType {
    [CmdletBinding()]
    param ()
    $ComputerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
    switch ($ComputerSystem.PCSystemType) {
        1 { $DeviceType = "Desktop" }
        2 { $DeviceType = "Laptop" }
        3 { $DeviceType = "Handheld" }
        4 { $DeviceType = "Docking Station" }
        5 { $DeviceType = "All-in-One" }
        6 { $DeviceType = "Sub-Notebook" }
        7 { $DeviceType = "Space-Saving" }
        8 { $DeviceType = "Lunch Box" }
        9 { $DeviceType = "Main System Chassis" }
        10 { $DeviceType = "Expansion Chassis" }
        11 { $DeviceType = "Sub-Chassis" }
        12 { $DeviceType = "Bus Expansion Chassis" }
        13 { $DeviceType = "Peripheral Chassis" }
        14 { $DeviceType = "Storage Chassis" }
        15 { $DeviceType = "Rack-Mount Chassis" }
        16 { $DeviceType = "Sealed-Case PC" }
        Default { $DeviceType = "Unknown" }
    }
    return $DeviceType
}
# Example usage:
Get-DeviceType