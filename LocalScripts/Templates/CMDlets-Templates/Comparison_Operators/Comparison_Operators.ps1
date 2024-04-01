    #ReadMe
<#
    
Comparison_Operators

[Oneline Version](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.2)

#>

#Script

# -match
$PS2State = Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root | Select-Object 'State'

if ( $PS2State -match 'Enabled' )
{
    Write-Host "Disabling PowerShell 2.0"
    
    Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root

    Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root | Select-Object 'State'
}
else
{
    Write-Host "PowerShell 2.0 is already disabled."
}
