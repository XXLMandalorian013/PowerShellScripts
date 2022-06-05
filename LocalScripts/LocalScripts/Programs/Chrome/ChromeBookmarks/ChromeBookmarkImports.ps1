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


#Check to see if Edge is installed to get ready for importing the bookmarks.

    #https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

    #Exit function https://adamtheautomator.com/powershell-exit/

        $PCName = $env:computername
        $UserName = $env:UserName

        $ProgramName = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

        if(Get-Item -Path $ProgramName -ErrorAction Ignore)
        {

        Write-Host "Chrome is Installed, importing Favorites for $UserName"

        }

        else

        {

        Write-Host "Chrome is not insalled, ending script"

        Exit

        }

#Copies Edge's Favorites from a location for importing. 

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item?view=powershell-7.2&WT.mc_id=ps-gethelp

        Copy-Item -Path "C:\Test\Bookmarks" -Destination  "C:\Users\$UserName\AppData\Local\Google\Chrome\User Data\Default\Bookmarks"