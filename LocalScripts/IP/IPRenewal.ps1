#Checks to see if the code is being ran "As Admin".
        Write-Host "Checking for elevated permissions..."
        if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Warning "This Terminal is not running as Admin, open a Terminal console as an administrator and run this script again."
        Break
        }
        else {
        Write-Host "The Terminal is running in a administrator...Running Code" -ForegroundColor Green
        }  

	Write-host "Starting ipconfig /release"

	ipconfig /release

	Start-Sleep -Seconds 45

	Write-host "ipconfig /flushdns"

	ipconfig /flushdns

	Start-Sleep -Seconds 45

	Write-host "ipconfig /renew"
	
	ipconfig /renew

	Start-Sleep -Seconds 

	Read-Host -Prompt "Press Enter to exit"