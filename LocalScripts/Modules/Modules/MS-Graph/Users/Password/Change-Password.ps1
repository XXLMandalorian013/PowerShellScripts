    #ReadMe
<#
Update-MGUPW
.DESCRIPTION
Update an existing user's MS Graph Password.
.PARAMETER Name
Specifies the file name.
.INPUTS
None. You cannot pipe objects to Add-Extension.
.OUTPUTS
VERBOSE: Update-MGUPW has started
VERBOSE: Update-MGUPW has finished
.LINK
[about_Functions_Advanced](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced?view=powershell-7.3)
[ConvertTo-SecureString](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/convertto-securestring?view=powershell-7.3)
[Connect-MSGraph](https://learn.microsoft.com/en-us/powershell/microsoftgraph/get-started?view=graph-powershell-1.0)
[Get-MgUser](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/get-mguser?view=graph-powershell-1.0)
[about_Hash_Tables](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables?view=powershell-7.3)
[Update-MgUserPassword](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/convertto-securestring?view=powershell-7.3)
[Update-MgUserPassword Example](https://learn.microsoft.com/en-us/graph/api/user-changepassword?view=graph-rest-1.0&tabs=powershell)
#>
#Region Start-Script
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
        Disconnect-MgGraph
        Write-Verbose 'Update-MGUPW has finished' -Verbose
    }
}
#Function to update an existing user's MS Graph Password.
Update-MGUPW
#EndRegion