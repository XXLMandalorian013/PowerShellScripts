    #ReadMe
<#

.DESCRIPTION
        
    Blocks the sign in of a user for all MS365 programs.  
    
    
.Notes

    Only works in 5.1 as Azure A/D currently only works in 5.1.

.INPUTS
        
    A user prinicpal name.

.OUTPUTS
    Already Blocked accts : 

    That users signins are already blocked.

    Once blocked : 
    
    useremail@domain.com Account Signin = False


.LINK
        
    https://learn.microsoft.com/en-us/microsoft-365/enterprise/block-user-accounts-with-microsoft-365-powershell?view=o365-worldwide

    https://learn.microsoft.com/en-us/powershell/module/azuread/get-azureaduser?view=azureadps-2.0

#>

#Script


$UserPrincipal = Read-Host "Type the user email address you wish to unblock signin."

$AcctSatus = (Get-AzureADUser -ObjectId $UserPrincipal).AccountEnabled

if ("$AcctSatus" -eq "False") {

    Set-AzureADUser -ObjectID "$UserPrincipal" -AccountEnabled $True

    Write-Host "$UserPrincipal Account Signin unblocked."

}

else {

    Write-Host "That users signins are already unblocked."

}
