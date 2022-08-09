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


#Check to see if Edge is installed to get ready for backing up the bookmarks.
    #https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2
    #Exit function https://adamtheautomator.com/powershell-exit/
    
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



#Copies Edge's Favorites to a location for backing up should they not be syncing or you just want a copy of them. Edge saves bookmarks to the destination below. Keep in mind the name Bookmarks after default is the actual bookmarks thems selves and not another folder. Bookmarks does not have a file extention type shown for some reason.

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item?view=powershell-7.2&WT.mc_id=ps-gethelp

        Copy-Item -Path "C:\Users\$UserName\AppData\Local\Microsoft\Edge\User Data\Default\Bookmarks" -Destination "C:\Test"
