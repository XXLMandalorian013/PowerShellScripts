#Connect to Azure Az w/ PS. A browser will open and prompt for Credential.

    #https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-8.0.0#sign-in

    Write-Host "Connecting to Azure A/D..."

    Start-Sleep -Seconds 1
    
    Write-Host "Opening browser...Please enter credential and close the browser after authentication"

    Start-Sleep -Seconds 1

    Connect-AzAccount

    Write-Host "Happy Clouding!"