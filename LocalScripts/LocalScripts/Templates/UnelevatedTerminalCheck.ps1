#Checks to see if the code is being ran "Unelevated".
Write-Host "Checking for elevated permissions..."
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {

Write-Warning "The Terminal is running in a administrator...Please run this script w/ out Elevation" 

Start-Sleep -Seconds 5

Exit

Break
}
else {

Write-Host "This Terminal is running un-elevated...running code." -ForegroundColor Green

}  