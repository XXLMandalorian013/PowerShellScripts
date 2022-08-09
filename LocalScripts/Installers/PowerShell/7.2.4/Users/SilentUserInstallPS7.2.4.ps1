#Checks to see if the code is being ran "Unelevated". For some reason installing PS 7.X.X this was requires un-elevated.
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

#https://docs.microsoft.com/en-us/windows/package-manager/winget/install    
    #Winget info
        #https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?WT.mc_id=THOMASMAURER-blog-thmaure&view=powershell-7
            #PS V 7.2.3.0
            winget install --ID Microsoft.PowerShell --source winget --version 7.2.4.0 --accept-source-agreements --accept-package-agreements --silent --force