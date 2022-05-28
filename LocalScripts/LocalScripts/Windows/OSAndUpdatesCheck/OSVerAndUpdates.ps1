$OSSN = Get-ComputerInfo | Select-Object OsSerialNumber

$OSInfo = Get-CimInstance Win32_OperatingSystem | Select-Object InstallDate, Caption, OSArchitecture, Version, BuildNumber

    $OSInfo | Format-List

        Write-Host "OS Serial Number"`r $OSSN

            Get-CimInstance win32_quickfixengineering |sort installedon -desc

                Write-Host Click URL to KBs and Winvers https://docs.microsoft.com/en-us/windows/release-health/release-information -Promt

