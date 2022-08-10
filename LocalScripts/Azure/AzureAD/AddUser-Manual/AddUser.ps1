#Checks to see if the code is being ran "As Admin".
            Write-Host "Checking for elevated permissions..."
            if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
            [Security.Principal.WindowsBuiltInRole] "Administrator")) {
            Write-Warning "This Terminal is not running as Admin, open a Terminal console as an administrator and run this script again."
            Break
            }
            else {
            Write-Host "The Terminal is running in a administrator...Running Code" -ForegroundColor Green
            }  

#Checks the PS terminal version this is ran in 5.X.X.

	##https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

	#Thanks to dotnVO for the help w/ this


#AzureAD only works in PS 5.1 atm.
	

	if ($PSVersionTable.PSVersion.Major -eq 5) {
		
		Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
	} else {
		
		Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 5.X.X...Ending Script" -WarningAction Inquire
		
		Exit
	}

#Adds a user to Azuer A/D.

    #https://docs.microsoft.com/en-us/powershell/module/azuread/new-azureaduser?view=azureadps-2.0

                                        # -AccountEnabled $true is required

    Write-Host "Please enter the fallowing for the new user being added"

    $DisplayName = Read-Host 'DisplayName' #Is required

    $Password = Read-Host 'Password' -AsSecureString #Is required

    $UserPrincipalName = Read-Host 'UserPrincipalName' #Is required

    $MailNickname = Read-Host 'MailNickname: Same as UserPrincipalName w/out the domain ' #Is required

    $CompanyName = Read-Host 'CompanyName' #Is required

    $UserType = Read-Host 'UserType: YourOrg = Member External = Guest'

    $City = Read-Host 'City'

    $StreetAddress = Read-Host 'Full Address'

    $PhysicalDeliveryOfficeName = Read-Host 'PhysicalDeliveryOfficeName'

    $Department = Read-Host 'Department'

    $Mobile = Read-Host 'Mobile or Home Number'

    $TelephoneNumber = Read-Host 'Office Number'


    $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $PasswordProfile.Password = "$Password"
    
    New-AzureADUser -DisplayName "$DisplayName" -PasswordProfile $PasswordProfile -UserPrincipalName "$UserPrincipalName" -AccountEnabled $true -MailNickName "$MailNickname" -CompanyName "$CompanyName" -UserType "$UserType" -City "$City" -StreetAddress "$StreetAddress" -PhysicalDeliveryOfficeName "$PhysicalDeliveryOfficeName" -Department "$Department" -Mobile "$Mobile" -TelephoneNumber "$TelephoneNumber"
