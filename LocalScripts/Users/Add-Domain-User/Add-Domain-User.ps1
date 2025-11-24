#This script should be run on a domain controller.
#Check if the Active Directory module is installed, else throws.
if (Get-Module -ListAvailable -Name ActiveDirectory) {
    Write-Verbose "Active Directory module is installed....Continuing script..." -Verbose
    Write-Verbose "Importing Active Directory..." -Verbose
    Import-Module ActiveDirectory
} else {
    Throw "Active Directory module is NOT installed...ending script..."
    Exit
}
#Get Domain
$Domain = "$env:USERDNSDOMAIN"
try {
    Write-Verbose -Message "Grabbing Domain..." -Verbose
    $Domain
}catch {
    Throw "Unable to get domain...ending script..."
    Exit
}
# Prompt for user information
Write-Verbose -Message "Please provide new AD user information..." -Verbose
$givenName         = Read-Host "Enter First Name"
$surname           = Read-Host "Enter Last Name"
$samAccountName    = Read-Host "Enter SamAccountName (e.g. jdoe)"
$userPrincipalName = Read-Host "Enter User Principal Name (e.g. jdoe@yourdomain.com)"
$ouPath            = Read-Host "Enter OU Path (e.g. OU=Users,OU=OU NameHere,DC=domainnamehere,DC=ds)"
$department        = Read-Host "Enter Department"
$title             = Read-Host "Enter Job Title (e.g. IT Support)"
$password          = Read-Host "Enter Password" -AsSecureString
# Check if UPN exists.
$existingUser = Get-ADUser -Filter "UserPrincipalName -eq '$userPrincipalName'" -ErrorAction SilentlyContinue
if ($existingUser) {
    Write-Host "A user with the UserPrincipalName '$userPrincipalName' already exists. User creation skipped." -ForegroundColor Red
    Exit
} else {
    # Create the user
    New-ADUser `
        -Name "$givenName $surname" `
        -GivenName $givenName `
        -Surname $surname `
        -DisplayName "$givenName $surname" `
        -SamAccountName $samAccountName `
        -UserPrincipalName $userPrincipalName `
        -EmailAddress $userPrincipalName `
        -Path "$ouPath" `
        -Department "$department" `
        -Title "$title" `
        -Company "Company Name" `
        -OfficePhone "(419)111-2223" `
        -AccountPassword "$password" `
        -Enabled $true `
        -PasswordNeverExpires $false
    Write-Host "User created successfully...please wait..." -ForegroundColor Green
}
Start-Sleep -Seconds 10
# Add the user to the specified group. Note, no need to specify Domain Users, as the user is automatically added to this group when created.
$Groups = @("Domain Admins", "Infrastructure Admins")
foreach ($Group in $Groups) {
    Write-Verbose -Message "Adding user to group $Group..." -Verbose
    Add-ADGroupMember -Identity $Group -Members "$samAccountName"
}
