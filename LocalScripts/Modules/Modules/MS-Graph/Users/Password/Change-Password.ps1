#------------------------------------

#Function to update an exsisting users MS Graph PW.


    #Connects to MS Graph with the ability to read and write user data.
    Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All"

    #Imports the required modules.
    Import-Module Microsoft.Graph.Users.Actions

    #Requests the exsisting and new PW to be updated.

    $EPW = Read-Host "Enter existing PW." -AsSecureString

    $EncryptedEPW = ConvertFrom-SecureString -SecureString $EPW

    $NPW = Read-Host "Enter new PW." -AsSecureString

    $EncryptedNPW = ConvertFrom-SecureString -SecureString $NPW

    #Grab the MS-Grpah Users name.

    $User = Read-Host "Type the users display name ie. Megan S. Bowen. If you are not sure, type Get-MgUser -All | Format-List  ID, 
    DisplayName, Mail, UserPrincipalName"

    $UserID = Get-MgUser -Filter "displayName eq '$User'"

    #Imports the required modules.
    Import-Module Microsoft.Graph.Users.Actions

    # A UPN can also be used as -UserId.
    Update-MgUserPassword -UserId "$UserId.id" -CurrentPassword "$EncryptedEPW" -NewPassword "$EncryptedNPW"




#Function to update an existing user's MS Graph Password.
function Update-MGUPW {

    param (

        [Parameter(Mandatory,HelpMessage='Type the users email ie bmfartz@domain.com')]
        [string]$UsersEMail,

        [Parameter(Mandatory,HelpMessage='Enter existing Password.')]
        [Security.SecureString] $ExistingPassword,

        [Parameter(Mandatory,HelpMessage='Enter new PW.')]
        [Security.SecureString] $NewPassword

    )

    #Connects to MS Graph with the ability to read and write user data.
    Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All"

    #Imports the required modules.
    Import-Module Microsoft.Graph.Users.Actions

    #Gets the user ID from its display names requested above.
    $UserID = Get-MgUser -Filter "Mail eq '$UsersEMail'"

    #Encrypts the passwords.
    $EncryptedEPW = ConvertFrom-SecureString -SecureString $ExistingPassword

    $EncryptedNPW = ConvertFrom-SecureString -SecureString $NewPassword

    #Hash table containing the parameters to Update-MgUserPassword.
    $UpdateMgUserPassword = @{

        UserId = $UserID.id

        CurrentPassword = $EncryptedEPW

        NewPassword =  $EncryptedNPW
    }

    #Call the MS Graph Actions CMDlet to update the user's password.
    Update-MgUserPassword @UpdateMgUserPassword

}

#Function to update an existing user's MS Graph Password.
Update-MGUPW

#Function to update an existing user's MS Graph Password.
function global:Update-MGUPW {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,HelpMessage='Type the users email ie bmfartz@domain.com')]
        [string]$UsersEMail,
        [Parameter(Mandatory,HelpMessage='Enter existing Password.')]
        [Security.SecureString] $ExistingPassword,
        [Parameter(Mandatory,HelpMessage='Enter new PW.')]
        [Security.SecureString] $NewPassword
    )
    begin{
        Write-Verbose 'Update-MGUPW has started' -Verbose
        #Imports the required modules.
        Import-Module Microsoft.Graph.Users.Actions
        #Connects to MS Graph with the ability to read and write user data.
        Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All"
    }
    process{
        #Gets the user ID from its display names requested above.
        $UserID = Get-MgUser -Filter "Mail eq '$UsersEMail'"
        #Encrypts the passwords.
        $EncryptedEPW = ConvertFrom-SecureString -SecureString $ExistingPassword
        $EncryptedNPW = ConvertFrom-SecureString -SecureString $NewPassword
        #Hash table containing the parameters to Update-MgUserPassword.
        $UpdateMgUserPassword = @{
            UserId = $UserID.id
            CurrentPassword = $EncryptedEPW
            NewPassword =  $EncryptedNPW
        }
        #Call the MS Graph Actions CMDlet to update the user's password.
        Update-MgUserPassword @UpdateMgUserPassword
    }
    
    end{
        Write-Verbose 'Update-MGUPW has finished' -Verbose
    }
}

#Function to update an existing user's MS Graph Password.
Update-MGUPW


#Function to update an existing user's MS Graph Password.
function global:Update-MGUPW {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,HelpMessage='Type the users email ie bmfartz@domain.com')]
        [string]$UsersEMail,
        [Parameter(Mandatory,HelpMessage='Enter existing Password.')]
        [Security.SecureString] [SecureString] $ExistingPassword,
        [Parameter(Mandatory,HelpMessage='Enter new PW.')]
        [Security.SecureString] [SecureString] $NewPassword
    )
    begin{
        Write-Verbose 'Update-MGUPW has started' -Verbose
        #Imports the required modules.
        Import-Module Microsoft.Graph.Users.Actions
        #Connects to MS Graph with the ability to read and write user data.
        Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All"
    }
    process{
        #Gets the user ID from its display names requested above.
        $UserID = Get-MgUser -Filter "Mail eq '$UsersEMail'"
        #Encrypts the passwords.
        $EncryptedEPW = ConvertFrom-SecureString -SecureString $ExistingPassword
        $EncryptedNPW = ConvertFrom-SecureString -SecureString $NewPassword
        #Hash table containing the parameters to Update-MgUserPassword.
        $UpdateMgUserPassword = @{
            UserId = $UserID.id
            CurrentPassword = $EncryptedEPW
            NewPassword =  $EncryptedNPW
        }
        #Call the MS Graph Actions CMDlet to update the user's password.
        Update-MgUserPassword @UpdateMgUserPassword
    }
    
    end{
        Write-Verbose 'Update-MGUPW has finished' -Verbose
    }
}

#Function to update an existing user's MS Graph Password.
Update-MGUPW


