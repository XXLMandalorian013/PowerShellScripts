    #ReadMe
<#

.DESCRIPTION
        
Grabs all mapped network drives via the registry.  
    
    
.Notes

Works in 5.1 or later.


.INPUTS
        
None.


.OUTPUTS
        
System.String.

PSChildName
-----------
A
K
M
Q
R
T

#>

#Script

$user = New-Object System.Security.Principal.NTAccount($env:UserName) 
$sid = $user.Translate([System.Security.Principal.SecurityIdentifier]) 
$SIDValue = $sid.Value

Get-ChildItem -Path "Registry::HKEY_USERS\$SIDValue\Network" | Select-Object "PSChildName"



