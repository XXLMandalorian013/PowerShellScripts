#Gets a list of all users AzureAD groups they are currently appart of. 

    #https://docs.microsoft.com/en-us/powershell/module/azuread/get-azureaduser?view=azureadps-2.0

    #https://docs.microsoft.com/en-us/powershell/module/azuread/get-azureadusermembership?view=azureadps-2.0


        $Search = Read-Host "Search for a Object ID, DisplayName or UserPrincipalName"

        Get-AzureADUser -SearchString "$Search" 

        $ObjectID = Read-Host "Enter users ObjectID"

        $UserMembership = Get-AzureADUserMembership -ObjectID $ObjectID

        $UserMembership | Select-Object DisplayName
        
        Get-AzureADUser | Format-List