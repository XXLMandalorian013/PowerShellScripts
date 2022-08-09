#GPU
$GPU = Get-CimInstance CIM_VideoController | Select-Object "InstallDate","VideoProcessor","Name","DriverVersion","DriverDate","MaxRefreshRate","MinRefreshRate","CurrentRefreshRate",
"videoModeDescription","CurrentHorizontalResolution","CurrentVerticalResolution"

    Write-Host "GPU"`r

        $GPU | Format-List
        
        $GPURAM = (Get-CimInstance CIM_VideoController | Measure-Object -Property AdapterRAM -Sum).sum /1gb

            Write-Host "GPU RAM $GPURAM GB"`r
