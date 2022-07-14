#Checks to see if the code is being ran "As Admin".

    #https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

    Write-Host "Checking for elevated permissions..."
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This Terminal is not running as Admin, open a Terminal console as an administrator and run this script again."
    Break
    }
    else {
    Write-Host "The Terminal is running in a administrator...Running Code" -ForegroundColor Green
    } 


#This script installs the BurntToast Module. If ran in PS V 7.X this script just installs BurntToast.
#When running this script via PS V 5.X, BurntToast requires Nuget and is installed.

	#https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2


		if(Get-InstalledModule -Name "BurntToast" -MinimumVersion 0.8.5 -ErrorAction Ignore){
   
   			Write-Host "BurntToast 0.8.5 is installed..."
    
     		Start-Sleep -Seconds 4



		} elseif ($PSVersionTable.PSVersion.Major -eq 7) {

    		Write-host "This script is running in $($PSVersionTable.PSVersion)."

   			Start-Sleep -Seconds 2

			Write-Host "Installing BurntToast 0.8.5..."

			Start-Sleep -Seconds 2

			Install-Module -Name "BurntToast" -MinimumVersion 0.8.5 -Force

			Get-InstalledModule -Name "BurntToast"



		} elseif ($PSVersionTable.PSVersion.Major -eq 5) {

    		Write-Host "This script is running in PowerShell $($PSVersionTable.PSVersion)."

   			Start-Sleep -Seconds 2

    		Write-Host "Installing Nuget 2.8.5.201..."

    		Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

   			Start-Sleep -Seconds 2

    		Write-Host "NuGet has been installed..."

    		Start-Sleep -Seconds 2

			Install-Module -Name "BurntToast" -MinimumVersion 0.8.5 -Force

			Get-InstalledModule -Name "BurntToast"

    		Write-Host "BurntToast is installed..."


		}

#Created a folder PS folder for coping the BurntToast Notification .jpg to.
    
    #https://docs.microsoft.com/en-us/powershell/scripting/samples/working-with-files-and-folders?view=powershell-7.2

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-path?view=powershell-7.2

        $TestPath = "C:\PS\"

        if(Test-Path -Path "$TestPath") {

            Write-Host "C\:PS Dir Exists for the BurntToast Notification .png..."

            Start-Sleep -Seconds 3

        }

        else

        {

            Write-Host "Creating C\:PS Dir for BurntToast Notification .png..."

            Start-Sleep -Seconds 2

            New-Item -Path 'C:\PS\' -ItemType Directory -ErrorAction Ignore

        }


#Checks to see if PS 7.X is installed, if not its installs it, as I run most of my script this way.

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.2
    
    #https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

        
        $ProgramName = "C:\Program Files\PowerShell\7\pwsh.exe"

        if(Get-Item -Path $ProgramName -ErrorAction Ignore)
        {
        
        Write-Host "PowerShell 7.X is already installed"
        
        }
        else
        {
        Write-Host "PowerShell 7.X install not found...Installing PowerShell 7.X"
        
        #https://docs.microsoft.com/en-us/windows/package-manager/winget/install    
            #Winget info
        #https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?WT.mc_id=THOMASMAURER-blog-thmaure&view=powershell-7
            #PS V 7.2.3.0
            winget install --ID Microsoft.PowerShell --source winget --version 7.2.4.0 --accept-source-agreements --accept-package-agreements --silent --force

        }
        
#Creates a dir for users running the Full C:/ script to output to.

        #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.2

        #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/read-host?view=powershell-7.2

        $FullCOutput = Read-Host "Please type the server dir name to be created. This is for users to output their Full C:\ .csv to,
                                  as well as for measure this dir when users output a Full C:\ .cvs prompting a BurntToast notification to be created on this PC..."


        if(Test-Path -Path "$FullCOutput") {

            Write-Host "$FullCOutput already exsists..."

            Start-Sleep -Seconds 3

        }

        else

        {

            Write-Host "Creating dir @ $FullCOutput for full C:\ output and measure..."

            Start-Sleep -Seconds 2

            New-Item -Path '$FullCOutput' -ItemType Directory -ErrorAction Ignore

        }


        