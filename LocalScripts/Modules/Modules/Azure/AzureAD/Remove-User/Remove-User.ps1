#Removes a AzureAD user.

    #https://docs.microsoft.com/en-us/powershell/module/activedirectory/remove-aduser?view=windowsserver2022-ps

        Get-AzureADUser -Top 99999999

        $ObjectID = Read-Host "Please type a User ObjectId to remove the user."

        Remove-AzureADUser -ObjectId $ObjectID
