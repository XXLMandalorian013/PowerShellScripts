    #ReadMe
<#

Get-All-MgUser.ps1
    
.SYNOPSIS

Gets all MG users.  
    
.Notes

Works in PS 5.1 and later.


.INPUTS
        
None.


.OUTPUTS
        
System.String,

Id                : 5asd77-9a18-42-1d6-sd6fe41
DisplayName       : User Name
Mail              : user.name@domain.com
UserPrincipalName : user.name_domain.com#EXT#@namehere23523123238.onmicrosoft.com


.LINK
        
[Get-MgUser](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/get-mguser?view=graph-powershell-1.0) 

#>

#Script


#Gets all Mg users.

# Parameter help description
[Parameter(AttributeValues)]
[ParameterType]
$ParameterName

$user = Get-MgUser -Filter "displayName eq 'Megan Bowen'"

Get-MgUser -All | Format-List  ID, DisplayName, Mail, UserPrincipalName
