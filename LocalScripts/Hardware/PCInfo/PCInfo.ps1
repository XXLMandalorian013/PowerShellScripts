$LogonServer = ComputerInfo | Select-Object LogonServer

$PCModel = Get-ComputerInfo | Select-Object CsManufacturer,CSModel



#Logon Server/PC Model/User/PC/Domain or Workgroup
    Write-Host "Log on Server:$LogonServer"  

        Write-Host "PC Model:$PCModel"

            Write-Host "PC Name:$env:computername"

                Write-Host "Logged in User:$env:UserName"

                    Write-Host "Domain or Workgroup:$env:USERDNSDOMAIN"

#Winver
$OSSN = Get-ComputerInfo | Select-Object OsSerialNumber

    $Winver = Get-CimInstance Win32_OperatingSystem | Select-Object InstallDate, Caption, OSArchitecture, Version, BuildNumber

        Write-Host "Windows Version"`r

            $Winver | Format-List

                Write-Host "OS Serial Number"`r $OSSN

#Bios
    $Bios = Get-CimInstance -Class CIM_BIOSElement |Select-Object Manufacturer,Name,SMBIOSBIOSVersion

        Write-Host "Bios"`r

            $Bios | Format-List

#CPU
    $CPU = Get-CimInstance -Class CIM_Processor |Select-Object Status,SocketDesignation,Manufacturer,Name,NumberOfCores,NumberOfEnabledCore,NumberOfLogicalProcessors,ThreadCount,CurrentClockSpeed,MaxClockSpeed,L2CacheSize,L3CacheSize,VoltageCaps

        Write-Host "CPU"`r

            $CPU | Format-List


#RAM
    $RAM = Get-CimInstance CIM_PhysicalMemory | Select-Object Tag,DeviceLocator,Manufacturer,PartNumber,SerialNumber,FormFactor,DataWidth,Speed,ConfiguredClockSpeed,ConfiguredVoltage

        Write-Host "RAM"`r
            
            $RAM | Format-table
            
                $RAMTotal = (Get-CimInstance CIM_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb
            
                    Write-Host "Total RAM $RAMTotal GB "`r

#GPU
$GPU = Get-CimInstance CIM_VideoController | Select-Object "InstallDate","VideoProcessor","Name","DriverVersion","DriverDate","MaxRefreshRate","MinRefreshRate","CurrentRefreshRate",
"videoModeDescription","CurrentHorizontalResolution","CurrentVerticalResolution"

    Write-Host "GPU"`r

        $GPU | Format-List
        
        $GPURAM = (Get-CimInstance CIM_VideoController | Measure-Object -Property AdapterRAM -Sum).sum /1gb

            Write-Host "GPU RAM $GPURAM GB"`r


#$CD Rom Drive
    $CDRomDrive = Get-CimInstance -Class CIM_CDROMDrive

        Write-Host "CD Rom Drive"`r

            $CDRomDrive | Format-List


#Local Disk Drive
$DiskDriveSize = Get-CimInstance CIM_DiskDrive

    Write-Host "Local Storage Media Size"`r

        $DiskDriveSize | Format-Table

$DiskDriveSizeRemaining = Get-Volume

        Write-Host "Local Storage Media Remaining Size"`r

            $DiskDriveSizeRemaining | Format-Table

#NetworkAdapter
    $NetworkAdapter = Get-CimInstance CIM_NetworkAdapter | FL

        Write-Host "Network Adapter"`r

            $NetworkAdapter | Format-Table


