#Region Start-Script

#Releses the PCs IP address, renews the PCs IP address, and clears the local IPs and DNS cache.
function Start-IPReleaseRewnewFlush {
    try{

        Write-Verbose -Message "Releasing the PCs IP Address" -Verbose

        Start-Sleep -Seconds 1

        #Releses the PCs IP address.
        ipconfig /release

        Start-Sleep -Seconds 3

    }catch {
        Throw $Error[0]
    }

    try {
            Write-Verbose -Message "Renewing the PCs IP address" -Verbose

            Start-Sleep -Seconds 1

            #Clears the local IPs and DNS cache.
            ipconfig /renew

            Start-Sleep -Seconds 3

        }catch {
        Throw $Error[0]
    }
    
    try {
        
        $NetworkConnectionTest = Test-NetConnection | Select-Object 'PingSucceeded'

            if ($NetworkConnectionTest -eq 'false') {
                do {
                    #Clears the local IPs and DNS cache.
                    ipconfig /flushdns

                    Start-Sleep -Seconds 5
                }until (
                    $NetworkConnectionTest -eq 'True'
                )   
            }
        #Clears the local IPs and DNS cache.
        ipconfig /flushdns
        Start-Sleep -Seconds 3
    }
    catch {
        Throw $Error[0]
    }
    finally {
        Write-Verbose -Message "Script complete." -Verbose

        Start-Sleep -Seconds 1

        Exit
    }

}

#Releses the PCs IP address, renews the PCs IP address, and clears the local IPs and DNS cache.
Start-IPReleaseRewnewFlush

#EndRegion

