$RegValue = Get-ItemProperty -Path "HKLM:\SOFTWARE\DNSFilter\Agent"

Write-verbose -Message "Grabbing the devices ProductGUID..." -Verbose

$GUID = $RegValue.ProductGUID

Write-verbose -Message "Running the uninstaller..." -Verbose

msiexec /X{$GUID} REGCLEAN=true

start-sleep -seconds 30

Write-verbose -Message "a reboot is required to finish the install...ending script..." -Verbose
