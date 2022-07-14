#Downloads software from the web. Make sure to add the downloads .exe full name in the -outfile file path or you will get access denied.

#***If you test this in MS Sandbox, make sure to run the Sandbox as Admin or the Invoke-WebResquest will infinatly count up and never download the item from the URL.***
    
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.2
      
    Write-Host "Downloding MS Teams for Work/School 64 Bit for all users"

    Invoke-WebRequest "https://go.microsoft.com/fwlink/p/?LinkID=2187327&clcid=0x409&culture=en-us&country=US" -OutFile "C:\TEMP\TeamsSetup_c_w_.exe"
