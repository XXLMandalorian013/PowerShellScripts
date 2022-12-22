<#
    
    .SYNOPSIS

        Disable NetFx3.
    
    
    .Notes

        Works in 5.1 or above and must be ran in an elevated terminal. The PC will need restarted for it to take effect.


    .OUTPUTS

        When Disabled

        FeatureName      : NetFx3
        DisplayName      : .NET Framework 3.5 (includes .NET 2.0 and 3.0)
        Description      : .NET Framework 3.5 (includes .NET 2.0 and 3.0)
        RestartRequired  : Possible
        State            : Enabled
        CustomProperties :
                   \FWLink : http://go.microsoft.com/fwlink/?LinkId=296822


    .LINK
        
        https://docs.microsoft.com/en-us/powershell/module/dism/enable-windowsoptionalfeature?view=windowsserver2022-ps
        
        https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.2
        

#>

#Script

#Elevated Terminal Check > Required for this CMD.

Write-Host "Checking for elevated permissions..."

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {

Write-Warning "This Terminal is not running as Admin, open a Terminal console as an administrator and run this script again."
Break
}

else 
{

Write-Host "The Terminal is running in a administrator...Running Code" -ForegroundColor Green

}

#Disable .Net 3.5 optional feature.

$FeatureState = Get-WindowsOptionalFeature -Online -FeatureName 'NetFx3' | Select-Object 'State'

if ($FeatureState -match 'Enabled')
{
    Write-Host "Disabling .Net 3.5"
    
    Enable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root

    Get-WindowsOptionalFeature -Online -FeatureName 'NetFx3' | Select-Object 'State'

    Write-Warning "A restart is require for this change to take effect... "

    Restart-Computer -Force -Confirm

}

else
{

    Write-Host "NetFx3 is already disabled."

}
