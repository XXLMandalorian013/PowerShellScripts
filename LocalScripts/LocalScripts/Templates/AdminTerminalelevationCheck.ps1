Write-Host "Checking for elevated permissions..."
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {
Write-Warning "This Terminal is not running "As Admin", Open a Terminal console as an administrator and run this script again."
Break
}
else {
Write-Host "Code is running in a administrator terminal..." -ForegroundColor Green
}