#Prompt for the local user account name.
$UserAccountName = Read-Host "Type the user account name"
#Will prmpt for a password.
New-LocalUser -Name "$UserAccountName" -PasswordNeverExpires -Description "Added a local Admin acct that never expires." -AccountNeverExpires
#Adds the local user to the local administrator group after the account is made.
Add-LocalGroupMember -Group "Administrators" -Member "$UserAccountName"