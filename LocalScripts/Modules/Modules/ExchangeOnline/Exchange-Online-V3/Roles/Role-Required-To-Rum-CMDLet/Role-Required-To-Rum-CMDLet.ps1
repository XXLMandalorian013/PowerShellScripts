    #ReadMe
<#
.DESCRIPTION
        
    Gets all roles required to run a CMDLet in Exchange Online.
    
    
.Notes

    ExchangeOnlineManagment Module only workin in PS 7.X.X.
    

.INPUTS
        
    A CMDLet name.


.OUTPUTS
        
    System.String.


.EXAMPLE
    
    CMDlet: New-ComplianceSearch

    Name           RoleType
    ----           --------
    Mailbox Search MailboxSearch


.LINK
        
    https://learn.microsoft.com/en-us/powershell/module/exchange/get-managementrole?view=exchange-ps

#>

#Script

param (
    [Parameter(Mandatory,HelpMessage='Type the CMDLets names')]
    [string]$CMDlet)


#Exchange Online module 2.0.5 (V2) and newer requires PS 7.X.X.


if ($PSVersionTable.PSVersion.Major -eq 7) {
		
	Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
} 

else {
	
    Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 7.X.X...Ending Script" -WarningAction Inquire
		
	Start-Sleep -Seconds 3

	Exit
}

Get-ManagementRole -Cmdlet $CMDlet
