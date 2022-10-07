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

Get-ManagementRole -Cmdlet $CMDlet
