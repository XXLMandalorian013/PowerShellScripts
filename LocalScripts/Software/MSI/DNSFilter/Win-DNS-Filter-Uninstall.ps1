#This script is for the standard roaming agent uninstall and not the MPS/White label version.
#Script
Write-verbose -Message "Checking the registry for DNSFilter...$RegValue" -Verbose
#Gets the registry value for the DNSFilter Agent.
$RegValue = Get-ItemProperty -Path "HKLM:\SOFTWARE\DNSFilter\Agent"
#Gets the product GUID from the registry.
$GUID = $RegValue.ProductGUID
if (-not $GUID) {
    throw "Can't quarry the registry for the product GUID...DNSFilter Agent does not seem to be installed...ending script..."
}else {
    Write-verbose -Message "GUID found...$GUID...Running the uninstaller..." -Verbose
    msiexec /X{$GUID} REGCLEAN=true
    Write-verbose -Message "Waiting 60 seconds for the uninstall to complete..." -Verbose
    start-sleep -seconds 60
    Write-verbose -Message "a reboot is required to finish the install...ending script..." -Verbose
}

