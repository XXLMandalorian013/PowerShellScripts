#Rename a PC by promting for imput.  
  #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-computer?msclkid=a39bb920d05d11ec8dd87209caaca6f1&view=powershell-7.2
      Write-Host "Checking for elevated permissions..."
      if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
      [Security.Principal.WindowsBuiltInRole] "Administrator")) {
      Write-Warning "Insufficient permissions to run this script. Open the PowerShell console as an administrator and run this script again."
      Break
      }
      else {
      Write-Host "Code is running as administrator — go on executing the script..." -ForegroundColor Green
      }
  
    $PCReName = Read-Host -Prompt "Enter PC's Name"

    Rename-Computer -NewName "$PCReName"