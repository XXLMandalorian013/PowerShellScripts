# All-Roles-Assigned-To-UserAll-Role

## DESCRIPTION

Gets all roles assigned to a user.

## Notes

ExchangeOnlineManagment Module only workin in PS 7.X.X.

## INPUTS

An Email of the Admin you wish to check.

## OUTPUTS

System.String.

## Example

   Role                                   RoleAssignee                                      RoleAssigneeType
    ----                                   ------------                                      ----------------
    View-Only Recipients                   View-Only Organization Management                 RoleGroup
    View-Only Recipients                   Compliance Management                             RoleGroup
    View-Only Recipients                   Hygiene Management                                RoleGroup
    View-Only Recipients                   Organization Management                           RoleGroup

# LINK

[Find the permissions required to run any Exchange cmdlet](https://learn.microsoft.com/en-us/powershell/exchange/find-exchange-cmdlet-permissions?view=exchange-ps)
