#Adds a user to Azuer A/D.

    #https://docs.microsoft.com/en-us/powershell/module/azuread/new-azureaduser?view=azureadps-2.0

    Write-Host "Please type the fallowing for the new user being added"

    $CompanyName = Read-Host 'CompanyName'

    $Department = Read-Host 'Department'

    $DisplayName = Read-Host 'DisplayName'

    $GivenName = Read-Host'GivenName'

    $JobTitle = Read-Host 'JobTitle'

    $UserPrincipalName = Read-Host 'UserPrincipalName'

    $Password = Read-Host 'Please Type Users Password'

    $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $PasswordProfile.Password = "$Password"

   

    New-AzureADUser -CompanyName "$CompaneyName" -Department "$Department" -DisplayName "$DisplayName" -GivenName "$GivenName" -JobTitle 'Technology Designer' -UserPrincipalName "TTTesttest@hawainc.com" -PasswordProfile $PasswordProfile -AccountEnabled $true

