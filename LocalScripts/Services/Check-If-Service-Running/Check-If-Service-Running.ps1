$ServiceName = "Sophos Connect Service"

$TestService = Get-Service -Name "Sophos Connect Service" -ErrorAction SilentlyContinue

$PreferedServiceStatus = "Running"

if ($PreferedServiceStatus -match $TestService.Status) {
    Write-Verbose -Message "$ServiceName is running...all is good." -Verbose
}else {
    Write-Verbose -Message "$ServiceName is not running...starting service." -Verbose
    Start-Service -Name "$ServiceName"
    Get-Service -Name "$ServiceName"
}
