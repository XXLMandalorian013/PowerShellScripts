
    #ReadMe
<#

New-MailboxRestoreRequest-Deligated.ps1
    

.DESCRIPTION
        
#A breakdown of the Process to restore a soft deleted mailbox.  


.LINK
        
[Connect-ExchangeOnline](https://learn.microsoft.com/en-us/powershell/module/exchange/connect-exchangeonline?view=exchange-ps)

[Get-Mailbox](https://learn.microsoft.com/en-us/powershell/module/exchange/get-mailbox?view=exchange-ps)

[Get-RetentionPolicy](https://learn.microsoft.com/en-us/powershell/module/exchange/get-retentionpolicy?view=exchange-ps)

[New-Mailbox](https://learn.microsoft.com/en-us/powershell/module/exchange/new-mailbox?view=exchange-ps)

[New-MailboxRestoreRequest](https://learn.microsoft.com/en-us/powershell/module/exchange/new-mailboxrestorerequest?view=exchange-ps)

#>

#Region Start-Script

#The -DelegatedOrganization switch must be used, ensuring we are on their tenant they deligated to us.
Connect-ExchangeOnline -DelegatedOrganization DemaskHoldings.onmicrosoft.com

#Ensure the mailbox is not still active. 
Get-Mailbox -Identity '*' | Sort-Object -Property alias

#Grab the Orgs retention Policy.
Get-RetentionPolicy

#Get-RetentionPolicy Example Output:
#Name                      RetentionPolicyTagLinks                                 Guid
#----                      -----------------------                                 ----
#ArbitrationMailbox        {Never Delete, AsyncOperationNotification,              82720ec4-9b45-493c-87ac-555ff0921191
#                          ModeratedRecipients, AutoGroup}
#Default MRM Policy        {5 Year Delete, 1 Year Delete, 6 Month Delete,          c1549ee7-dcca-49fe-a59f-b03578044de3
#                          Personal 5 year move to archive…}


#Getting the idendity for the soft deleted email. When pluging in the identity, be sure to cut off the prefix "Soft Deleted Objects\" and just ender the name. ie dplagueis.
Get-Mailbox -SoftDeletedMailbox -Identity dplagueis | Select-Object 'Identity'

#Get-Mailbox idendity example output:
#Identity
#--------
#Soft Deleted Objects\dplagueis

#Create the new/exsisting user mailbox. Be sure to store the password! When restoring an exsisting email into a new email with the same email address, its best to use the exact names as before.
New-Mailbox -Alias dplagueis -Name Darthp -FirstName Darth -LastName Plagueis -DisplayName "Darth Plagueis" -MicrosoftOnlineServicesID dplagueis@demaskholdings.com -Password (ConvertTo-SecureString -String 'restore1234!' -AsPlainText -Force)

#New-Mailbox Output Example:
#Name                      Alias           Database                       ProhibitSendQuota    ExternalDirectoryObjectId
#----                      -----           --------                       -----------------    -------------------------
#Darthp                dplagueis      NAMPR03DG442-db070             99 GB (106,300,440,… d2333746-1539-45b6-a68f-7ee14a70c63a

#To grab the new/exsisting mailboxe's ExchangeGuid.
Get-Mailbox -SoftDeletedMailbox -Identity dplagueis | Select-Object 'ExchangeGuid'

#Target/deleted Get-Mailbox Example Output:
#ExchangeGuid
#------------
#637bc95d-d47b-4acf-9e71-4696c52ea0ce

#To grab the target/deleted mailboxe's ExchangeGuid.
Get-Mailbox -Identity dplagueis | Select-Object 'ExchangeGuid'

#Target/deleted Get-Mailbox Example Output:
#ExchangeGuid
#------------
#1fb5789d-3599-4f3d-af37-766a1e9bbbec

#SourceMailbox is the delete mailbox's ExchangeGuid and TargetMailbox is the new/recreated/exsisting ExchangeGuid. The optional peramiter -AllowLegacyDNMismatch may be required. Note, the TargetMailbox is just the mailboxes name. ie -Name Darthp.
New-MailboxRestoreRequest -SourceMailbox 637bc95d-d47b-4acf-9e71-4696c52ea0ce -TargetMailbox 1fb5789d-3599-4f3d-af37-766a1e9bbbec -AllowLegacyDNMismatch

#New-MailboxRestoreRequest Output example:
#Name           TargetMailbox Status
#----           ------------- ------
#MailboxRestore Darthp    Queued

#AllowLegacyDNMismatch Error:
#New-MailboxRestoreRequest: |Microsoft.Exchange.MailboxReplicationService.NonMatchingLegacyDNPermanentUseSwitchException|Source mailbox's legacyExchangeDN '/o=ExchangeLabs/ou=Exchange Administrative Group
#(FYDIBOHF23SPDLT)/cn=Recipients/cn=2816ea4c937e41158e007480064df7f0-dplagueis' doesn't match the legacyExchangeDN or X500 proxy for target mailbox
#'1fb5789d-3599-4f3d-af37-766a1e9bbbec'. Use the 'AllowLegacyDNMismatch' switch if you want to allow this operation.

#AllowLegacyDNMismatch Error Fix:
#As stated, use the -AllowLegacyDNMismatch switch if you want to allow this operation.

#Getting the mailbox restore status. Grab the -TargetMailbox from the output of 
Get-MailboxRestoreRequest -TargetMailbox TargetMailbox

#Get-MailboxRestoreRequest Output example:
#Name           TargetMailbox Status
#----           ------------- ------
#MailboxRestore Darthp     Completed

#When the restore is done, be sure to disconnect from exchange online.
Disconnect-ExchangeOnline

#EndRegion


