# Checks to see if PS 7 is installed, if not it will install it
  #Make sure to add the file name & type after the last sub folder
  $ProgramName = "C:\Program Files\PowerShell\7\pwsh.exe"

  if(Get-Item -Path $ProgramName -ErrorAction Ignore)
  {
  
 Write-Host "Program Exists"
  
  }
  else
  {
  Write-Host "Program Doesn't Exists"
  
  # Silently installs Program PS 7.2 w/ all the options selected
  winget install --ID Microsoft.PowerShell --version 7.2.1.0 --silent
  }

#Import task to task scheduler
  # Registers the task scheduler xport file and changes the credentails on the task to be ran as the logged in PC.
  # Make sure to make create task locally on my PC first, make sure it runs then swap out the TaskScheduler export location below
$Domain = $env:USERDNSDOMAIN
$UserName = $env:UserName

Register-ScheduledTask -Xml (Get-Content "\\Server\Folder\SFC.xml" | Out-String) -TaskName "SFC" -User $Domain\$UserName –Force
