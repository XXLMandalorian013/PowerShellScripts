    #ReadMe
<#
    
    .SYNOPSIS

        Finds a Module by searching for it by name.
    
    
    .Notes

        Works in 5.1 and later.


    .LINK
        
        [Find-Module Online Version](https://learn.microsoft.com/en-us/powershell/module/powershellget/find-module?view=powershell-7.2)

        [Get-InstalledModule OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/powershellget/get-installedmodule?view=powershell-7.2)   

#>

#Script


#Terminal must be ran as elevated to install a Module

if (! ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Error "This script requires Administrator rights. To run this cmdlet, start PowerShell with the `"Run as administrator`" option."
    return
}


#Search and narrow down Module

$ModuleName = Read-Host 'Type a name or pharase you wish to search.'

Find-Module -Filter $ModuleName -ErrorAction SilentlyContinue

$EModuleName = Read-Host "To search deeper on a specific module, type exact name."

Find-Module -Name $EModuleName -AllVersions -ErrorAction SilentlyContinue


#Module check/install.

Write-Warning "Checking if the specified module is install..."

if (Get-InstalledModule -Name $EModuleName -ErrorAction SilentlyContinue) {
    
    Write-Host "$EModuleName" is already installed...

    Get-InstalledModule -Name $EModuleName -ErrorAction SilentlyContinue

}
else {
    Write-Host "$EModuleName module not found...install it?" -ForegroundColor red

    $ModuleVer = Read-Host "Enter Required Version"

    Install-Module -Name $EModuleName -RequiredVersion $ModuleVer

    Get-InstalledModule -Name $EModuleName -ErrorAction SilentlyContinue
}




