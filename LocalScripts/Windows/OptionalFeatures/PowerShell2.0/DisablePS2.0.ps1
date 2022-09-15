<#
    
    .SYNOPSIS

        Disables PowerShell 2.0 Engine.
    
    
    .Notes

        Works in 5.1 or above and must be ran in an elevated terminal. The PC will need restarted for it to take effect.


    .OUTPUTS

        When Enabled

            Disabling PowerShell 2.0
            Path          :
            Online        : True
            RestartNeeded : False

            State : Disabled

        When already Disabled
        
            PowerShell 2.0 is already Disabled.


    .LINK
        
        https://docs.microsoft.com/en-us/powershell/module/dism/enable-windowsoptionalfeature?view=windowsserver2022-ps
        
        https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.2

        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/restart-computer?view=powershell-7.2

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

#Disable PS 2.0 optional feature.

$PS2State = Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root | Select-Object 'State'

if ( $PS2State -match 'Enabled' )
{
    Write-Host "Disabling PowerShell 2.0"
    
    Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root

    Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root | Select-Object 'State'

    Write-Warning "A restart is require for this change to take effect... "

    Restart-Computer -Confirm

}

else
{

    Write-Host "PowerShell 2.0 is already disabled."

}
