    #ReadMe
<#
    
    .SYNOPSIS

        Finds a Module by searching for it by name.
    
    
    .Notes

        Works in 5.1 and later.


    .LINK
        
        [Find-Module Online Version](https://learn.microsoft.com/en-us/powershell/module/powershellget/find-module?view=powershell-7.2)

#>

#Script

param(
    [Parameter(Mandatory,HelpMessage='Type a name or pharase you wish to search.')]
    [string]$ModuleName)

Find-Module -Filter $ModuleName -ErrorAction SilentlyContinue

$EModuleName = Read-Host "To search deeper on a specific module, type exact name."

Find-Module -Name $EModuleName -AllVersions -ErrorAction SilentlyContinue