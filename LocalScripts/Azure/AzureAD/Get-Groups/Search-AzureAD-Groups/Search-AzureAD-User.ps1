#Search for an AD group by Object ID, DisplayName or UserPrincipalName
    
    #https://docs.microsoft.com/en-us/powershell/module/azuread/get-azureadgroup?view=azureadps-2.0


        $Search = Read-Host "Search for a Object ID, DisplayName or UserPrincipalName"

        Get-AzureADGroup -SearchString "$Search"