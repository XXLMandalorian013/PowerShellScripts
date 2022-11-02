#Gets all installed programs from the resgistry.
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-itemproperty?view=powershell-7.2
    Get-CimInstance -Class Win32_Product | Select-Object "Name", "Version" | Sort-Object "Name"




