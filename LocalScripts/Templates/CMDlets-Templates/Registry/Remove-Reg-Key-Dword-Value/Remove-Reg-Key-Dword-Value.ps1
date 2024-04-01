    #ReadMe
<#
    
    .DESCRIPTION
        
        Removes Reg Key DWORD Value.
    
    .Notes
    
    Works in 5.1 and later.


    .LINK
        
        Online version: https://docs.microsoft.com/en-us/powershell/scripting/samples/working-with-registry-keys?view=powershell-7.2
        
        [Online Version](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.2)

#>

#Script

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

#Reg changes require elevated terminal. 

#Make sure to keep the Registry:: before the actual Reg key.

Remove-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\TEST' -Name 'TestDW' -Force