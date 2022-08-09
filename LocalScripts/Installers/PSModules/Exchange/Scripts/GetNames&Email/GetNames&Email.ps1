#Gets Exchange email list and the users name.

    #https://docs.microsoft.com/en-us/powershell/module/exchange/get-exomailbox?view=exchange-ps

        Get-EXOMailbox | Select-Object 'DisplayName', 'UserPrincipalName', 'RecipientType' | Format-List