#Local Disk Drive
$DiskDriveSize = Get-CimInstance CIM_DiskDrive

    Write-Host "Local Storage Media Size"`r

        $DiskDriveSize | Format-Table

$DiskDriveSizeRemaining = Get-Volume

        Write-Host "Local Storage Media Remaining Size"`r

            $DiskDriveSizeRemaining | Format-Table