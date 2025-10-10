#Notes
# Sophos Uninstall: https://docs.sophos.com/esg/endpoint/help/en-us/help/Uninstall/index.html
#Vars
$InstalledPath = "C:\Program Files\Sophos\Sophos Endpoint Agent"
$UninstallerPath = "C:\Program Files\Sophos\Sophos Endpoint Agent"
$UninstallerName = "SophosUninstall.exe"
#If Sophos Endpoint Agent is installed, it uninstalls it.
if (Test-Path "$InstalledPath") {
        Write-Verbose "Sophos Endpoint Agent is installed...uninstalling " -Verbose
        Set-Location -Path $InstalledPath
        Start-Process -FilePath "$UninstallerPath\$UninstallerName" -ArgumentList "--quiet" -Wait
        Start-Sleep -Seconds 5
        #Uninstall check.
        try {
            do { 
                $TestPath = Test-Path -Path "$ProgramPath"
                if ($TestPath -eq 'True') {
                        Write-Verbose -Message "$UninstallerName uninstaller is running...Please wait" -Verbose
                        Start-Sleep -Seconds 8
                    }
                }Until ($TestPath -ne 'True')
                Write-Verbose -Message "$UninstallerName uninstalled!" -Verbose
        }catch {
            Write-Error "An error occurred while checking the uninstallation status: $_"
    }else {
        Throw "Sophos Endpoint Agent is not installed...ending script"
    }
}

