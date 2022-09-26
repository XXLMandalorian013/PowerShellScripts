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


