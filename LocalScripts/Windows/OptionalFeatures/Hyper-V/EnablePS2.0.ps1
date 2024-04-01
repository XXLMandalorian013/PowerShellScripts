<#
    
    .SYNOPSIS

        Enabled PowerShell Hyper-V.
    
    
    .Notes

        Works in 5.1 or above and must be ran in an elevated terminal. The PC will need restarted for it to take effect.


    .OUTPUTS

        When Disabled

            Enabling PowerShell Hyper-V
    

        When already Enabled
        
            @{FeatureName=Microsoft-Hyper-V} already @{State=Enabled}.


    .LINK
        
        https://docs.microsoft.com/en-us/powershell/module/dism/enable-windowsoptionalfeature?view=windowsserver2022-ps
        
        https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.2

        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/restart-computer?view=powershell-7.2

#>

#Script


#Elevated Terminal Check > Required for this CMD.

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
    
}


$FeatureState = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V | Select-Object 'State'

$FeatureName =  Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V | Select-Object 'FeatureName'


#Enables Hyper-V optional feature.

if ("$FeatureState" -match 'Disabled')
{
    Write-Host "Enabling $FeatureName..."
    
    Enable-WindowsOptionalFeature -Online -FeatureName "$FeatureName"

    Write-Warning "A restart is require for this change to take effect... "

    Restart-Computer -Force -Confirm

}else
{

    Write-Host "$FeatureName already $FeatureState."

}


