#Search for an AD user by Object ID, DisplayName or UserPrincipalName
    
    #https://docs.microsoft.com/en-us/powershell/module/azuread/get-azureaduser?view=azureadps-2.0


        $Search = Read-Host "Search for a Object ID, DisplayName or UserPrincipalName"

        Get-AzureADUser -SearchString "$Search"