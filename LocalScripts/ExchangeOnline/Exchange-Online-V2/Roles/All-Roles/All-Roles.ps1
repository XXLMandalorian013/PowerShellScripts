    #ReadMe
<#
.DESCRIPTION
        
    Gets all Exchange Roles
    
    
.Notes

    ExchangeOnlineManagment Module only workin in PS 7.X.X.
    

.INPUTS
        
    None.


.OUTPUTS
        
    System.String.


.EXAMPLE
        
    Role                                   RoleAssignee                                      RoleAssigneeType
    ----                                   ------------                                      ----------------
    View-Only Recipients                   View-Only Organization Management                 RoleGroup
    View-Only Recipients                   Compliance Management                             RoleGroup
    View-Only Recipients                   Hygiene Management                                RoleGroup
    View-Only Recipients                   Organization Management                           RoleGroup


.LINK
        
    https://learn.microsoft.com/en-us/powershell/exchange/find-exchange-cmdlet-permissions?view=exchange-ps

#>

#Script


$ParamArray = @(

    "Role"
    "RoleAssignee"
    "RoleAssigneeType"
  
  )
  
Get-ManagementRoleAssignment -Role "*" - | Format-Table $ParamArray
  