#Must be connected to ExchangeOnline already as the client or through deligated permissions befor running this script.

#The shared mailbox.
$mailbox = 'MailboxName@domain.com'

#The user to be granted access to the maailbox.
$User = 'UsersEmail@domain.com'

Add-RecipientPermission -Identity $mailbox -Trustee $user -AccessRights SendAs -Confirm:$false
