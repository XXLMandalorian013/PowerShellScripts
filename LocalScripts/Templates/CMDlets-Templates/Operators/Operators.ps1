    #ReadMe
   
# about_Operators

## Links

[OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.2)


#Script

#Equil = -eq #1

$PS2State = Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root | Select-Object 'State'

if ( $PS2State -eq 'Enabled' )
{
    Write-Host "Disabling PowerShell 2.0"
    
    Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root

    Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root | Select-Object 'State'
}
else
{
    Write-Host "PowerShell 2.0 is already disabled."
}


#Equil = -eq #2

$ModuleName = 'ExchangeOnlineManagement'

$Module = Get-InstalledModule -Name "$ModuleName" | Select-Object 'Name'

if ( $Module -eq $Module )
{
    Write-Host "$Module installed"
}
else
{
    Write-Host "$Module is not installed"
}

<#



#>


# Match = -match #1 

## Am I already connected to ExchangeOnline?

$PSSessionsName = Get-PSSession | Select-Object -Property "Name"

if ("$PSSessionsName" -match 'ExchangeOnlineInternalSession') 
{
    Throw "Your are already connected to $PSSessionsName"
}   
else
{
    Write-Host 'Starting connection to ExchangeOnlineInternalSession'

}  

<#

Match is best used when the return string has more then one possible return string. In the example above I was wanting to test if I was already connected to ExchangeOnline.

When already connected to the exchange. Using Get-PSSEssion returns,

PS C:\Users\DAM> Get-PSSession | Select-Object -Property "Name"

Name
----
ExchangeOnlineInternalSession_1

Depending on who is already connected and/or if you have recently connected the output could be,

ExchangeOnlineInternalSession_2,

ExchangeOnlineInternalSession_4, or even

ExchangeOnlineInternalSession_6

Since I wont know what exact connection name I'll get, I used match. If I had used -eq (Equils) it would be looking for, 

ExchangeOnlineInternalSession_1 

exactly everytime, though I may already be connected as 

ExchangeOnlineInternalSession_5,

and it allows me to connect again having multiple PSSessions open. This is not ideal as the defult number of connecitions to Exchange at one time is 3.

#>

# Match = -match #2

$AllUsers = Get-AzureADUser | Select-Object UserPrincipalName

$AllUsers -match 'domain.com' #Change to your Org


<#

I wanted to get all internal users, and ```Get-AzureADUser``` lists internal and external.

PS C:\Windows\system32> Get-AzureADUser

ObjectId                             DisplayName                           UserPrincipalName
--------                             -----------                           -----------------
d24ss8a07-1sb-45as-9002-d65basd email@gmail.com                     Guest_gmail.com#EXT#@provider365101014...
d24ss8a07-1sb-45as-9002-d65basd ARealPerson1                        ARealPerson1@mydomain.com
d24ss8a07-1sb-45as-9002-d65basd email@domain.com                    ARealPerson2@mydomain.com
d24ss8a07-1sb-45as-9002-d65basd ARealPerson2                        Guest_gmail.com#EXT#@provider365101014...
d24ss8a07-1sb-45as-9002-d65basd ARealPerson2                        ARealPerson3@mydomain.com

To narrow down just the userprinciplals, I piped,

Get-AzureADUser | Select-Object UserPrincipalName

returning,

UserPrincipalName
--------
Guest_gmail.com#EXT#@provider365101014...
ARealPerson1@mydomain.com
ARealPerson2@mydomain.com
Guest_gmail.com#EXT#@provider365101014...
ARealPerson3@mydomain.com

To filter just internal users I used -match since ```ARealPerson3@mydomain.com``` is one long string and there is no segmentation of just domain in ```Get-AzureADUser```.

#>