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

  
#Exchange Online module 2.0.5 (V2) and newer requires PS 7.X.X.


if ($PSVersionTable.PSVersion.Major -eq 7) {
		
	Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
} 

else {
	
    Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 7.X.X...Ending Script" -WarningAction Inquire
		
	Start-Sleep -Seconds 3

	Exit
}

Get-ManagementRoleAssignment -Role "*" | Format-Table $ParamArray
  