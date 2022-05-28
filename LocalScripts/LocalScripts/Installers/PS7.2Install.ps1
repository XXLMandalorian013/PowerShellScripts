#https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?WT.mc_id=THOMASMAURER-blog-thmaure&view=powershell-7
    #The following example shows how to silently install PowerShell with all the install options enabled. See URL above.
    msiexec.exe /package PowerShell-7.2.1-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 USE_MU=1 ENABLE_MU=1

#https://docs.microsoft.com/en-us/windows/package-manager/winget/install    
    #Winget info
        #https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?WT.mc_id=THOMASMAURER-blog-thmaure&view=powershell-7
            #PS V 7.2.1.0
                winget install --ID Microsoft.PowerShell --source winget --version 7.2.3.0 --accept-source-agreements --accept-package-agreements --silent