#Pass the function into a variable, the Get-ItemProperty is grabbing the installed programs in the Registry. Make sure to never add formatting like Formate-Table, -AutoSize when passing a function to a variable,
#or it wont output anything make sure to do it below when out-putting the variable. See second part of the code.
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-itemproperty?view=powershell-7.2
            $Programs = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate


#Sort the Installed Programs in the Registry to equil a specific programs DisplayName. Be sure to find the exact Display name and enter after the -eq
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/where-object?view=powershell-7.2
        $Programs | Where-Object -Property "DisplayName" -eq "ESET Endpoint Antivirus" | Format-Table –AutoSize