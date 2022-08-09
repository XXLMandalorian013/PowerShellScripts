#Detects if a program is installed before contuning.
	
	#https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

		$PCName = $env:computername
		$UserName = $env:UserName

		$ProgramName = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

		if(Get-Item -Path $ProgramName -ErrorAction Ignore)
		{

		Write-Host "Edge is Installed, backing up Favorites for $UserName"

		}

		else

		{

		Write-Host "Edge is not insalled, ending script"
	
		Start-Sleep -seconds 5

		Exit

		}
