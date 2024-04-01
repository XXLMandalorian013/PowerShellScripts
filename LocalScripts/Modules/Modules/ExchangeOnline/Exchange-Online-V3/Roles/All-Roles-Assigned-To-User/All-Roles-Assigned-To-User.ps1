    #ReadMe
<#
.DESCRIPTION
        
    Gets all Admin Users Exchange Roles
    
    
.Notes

    ExchangeOnlineManagment Module only workin in PS 7.X.X.
    

.INPUTS
        
    An Email of the Admin you wish to check.


.OUTPUTS
        
    System.String.


.EXAMPLE
        
    Role                                   RoleAssignee                   RoleAssigneeType
    ----                                   ------------                   ----------------
    Retention Management                   Organization Management        RoleGroup
    My Custom Apps                         Organization Management        RoleGroup
    Recipient Policies                     Organization Management        RoleGroup


.LINK
        
    https://learn.microsoft.com/en-us/powershell/exchange/find-exchange-cmdlet-permissions?view=exchange-ps

#>

#Script

param (
    [Parameter(Mandatory,HelpMessage='Type the email you wish to check the roles for.')]
    [string]$RoleAssignee)


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

Get-ManagementRoleAssignment -RoleAssignee $RoleAssignee | Format-Table $ParamArray


