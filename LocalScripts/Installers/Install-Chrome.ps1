#PS must be ran elevated here or Chrome will prompt for UAC casuing the .msi -ArgumentList "/quiet /norestart" to not work and not install chrome.

Write-Host "Checking for elevated permissions..."

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {

Write-Warning "This Terminal is not running as Admin, open a Terminal console as an administrator and run this script again."
Break
}

else 
{

Write-Host "The Terminal is running in a administrator...Running Code" -ForegroundColor Green

}

#Can I dial out?

$NetworkConnection = Test-NetConnection | Select-Object 'PingSucceeded'

if ($NetworkConnection -match 'True')
{
    Write-Host "Network connection confirmed!"
}
else
{
    Throw "Check network connection"
}

#Checks if Chrome is installed, if not it installs it via a URL.

if (Test-Path -Path "C:\Program Files\Google\Chrome\Application\chrome.exe") {

    Write-Host 'Chrome is already installed...Ending Script' -ForegroundColor Green

    Start-Sleep -Seconds '4'

    Exit
}
else {
    
    Write-Host 'Chrome not found...Installing Chrome.' -ForegroundColor Red

    Start-Sleelp -Seconds '4'

    Invoke-WebRequest 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi' -OutFile $env:TEMP\chrome.msi

    Start-Process -FilePath $env:TEMP\chrome.msi -ArgumentList "/quiet /norestart" -Wait

    Test-Path -Path "C:\Program Files\Google\Chrome\Application\chrome.exe"

    Remove-Item $env:TEMP\chrome.msi

    Write-Host 'Finished...Ending Script'

    Start-Sleelp -Seconds '4'

    Exit
}

