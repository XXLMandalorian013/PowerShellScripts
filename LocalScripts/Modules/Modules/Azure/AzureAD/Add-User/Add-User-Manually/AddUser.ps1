    #ReadMe
<#
    
    .SYNOPSIS

        Adds a user to Azure AD.


    .DESCRIPTION
        
        Prompts for imput to be enter for a new user. All required imputs are noted by #Is required.


    .OUTPUTS
        
        ObjectId                             DisplayName  UserPrincipalName  UserType
        --------                             -----------  -----------------  --------
        1232Sc2-6sac-111-b2b2-d07e889344543s Test A. User  TAUser@domain.com   Member


    .LINK
        
        #https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

        #https://docs.microsoft.com/en-us/powershell/module/azuread/new-azureaduser?view=azureadps-2.0

#>

#Script


#Checks to see if the code is being ran "As Admin".

Write-Host "Checking for elevated permissions..."

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`

[Security.Principal.WindowsBuiltInRole] "Administrator")) {

 Write-Warning "This Terminal is not running as Admin, open a Terminal console as an administrator and run this script again."

Break

} else {

 Write-Host "The Terminal is running in a administrator...Running Code" -ForegroundColor Green

}  

#Checks the PS terminal version this is ran in 5.X.X.

#Thanks to dotnVO for the help w/ this

#AzureAD only works in PS 5.1 atm.
	

if ($PSVersionTable.PSVersion.Major -eq 5) {
		
	Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
} else {
		
    Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 5.X.X...Ending Script" -WarningAction Inquire
	
    Start-Sleep -Seconds 3
    
    Exit

}

#Adds a user to Azuer A/D.

Write-Host "Please provide the fallowing for Azure AD"

$DisplayName = Read-Host 'Full A. Name' #Is required

$Password = Read-Host 'Password' -AsSecureString #Is required

$UserPrincipalName = Read-Host 'Email' #Is required

$MailNickname = Read-Host 'Initials' #Is required

$CompanyName = Read-Host 'Company Name' #Is required

$UserType = Read-Host 'UserType: YourOrg = Member External = Guest'

$Department = Read-Host 'Department'

$JobTitle = Read-Host 'Job Title'

$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

$PasswordProfile.Password = "$Password"

# -AccountEnabled $true peramiter #Is required.

New-AzureADUser -DisplayName "$DisplayName" -PasswordProfile $PasswordProfile -UserPrincipalName "$UserPrincipalName" -AccountEnabled $true -MailNickName "$MailNickname" -CompanyName "$CompanyName" -UserType "$UserType" -Department "$Department" -JobTitle $JobTitle

    



