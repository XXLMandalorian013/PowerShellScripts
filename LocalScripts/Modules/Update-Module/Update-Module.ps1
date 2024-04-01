    #ReadMe
<#
    
    .SYNOPSIS

        Updates a Module by propting for its name and reqired version 
    
    
    .Notes

        Works in 5.1 and later.


    .LINK
        
        [​Update-Help Online Version](https://learn.microsoft.com/en-us/powershell/module/powershellget/update-module?view=powershell-7.2)

#>

#Script


#Must be ran as elevated as when installing it will throw that the module is in use.

if (! ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Error "This script requires Administrator rights. To run this cmdlet, start PowerShell with the `"Run as administrator`" option."
    return
}

#Upates Module baced on imput

$ModuleName = Read-Host 'Enter a Modules Name'

$ModuleVer = Read-Host 'Enter the Required Module Version'

Update-Module -Name $ModuleName -RequiredVersion $ModuleVer -Force

