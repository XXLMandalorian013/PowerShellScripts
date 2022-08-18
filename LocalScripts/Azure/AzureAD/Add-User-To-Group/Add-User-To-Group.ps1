#TEST/WIP

        Get-AzureADGroup | Select-Object DisplayName

        Add-AzureADGroupMember -ObjectId "62438306-7c37-4638-a72d-0ee8d9217680" -RefObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"






        Get-AzureADGroup | Where-Object {$_.Id -eq Description }









#Gets a list of all users AzureAD groups they are currently appart of. 

    #https://docs.microsoft.com/en-us/powershell/module/azuread/get-azureaduser?view=azureadps-2.0

    #https://docs.microsoft.com/en-us/powershell/module/azuread/get-azureadusermembership?view=azureadps-2.0


    $Search = Read-Host "Search for a Object ID, DisplayName or UserPrincipalName"

    Get-AzureADUser -SearchString "$Search" 

    $ObjectID = Read-Host "Enter users ObjectID"

    $UserMembership = Get-AzureADUserMembership -ObjectID $ObjectID

    $UserMembership | Select-Object DisplayName