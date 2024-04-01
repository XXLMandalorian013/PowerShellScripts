#Old log cleanup

$Path = "C:\Scripts\Ad-Managers\Data\AD-CSV-Import-Logs"

$Daysback = "-30"

$CurrentDate = Get-Date

$DatetoDelete = $CurrentDate.AddDays($Daysback)

Get-ChildItem $Path | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item

# logging

$Date = Get-Date -Format "MM-dd-yyyy"

Start-Transcript -Path "C:\Scripts\Ad-Managers\Data\AD-CSV-Import-Logs\NEW$date.log"


Import-Module ActiveDirectory

# Read the CSV file

$userList = Import-Csv -Path "C:\Scripts\Ad-Managers\Data\AD-CSV-Import\Ad-User-Updates.csv"

# Loop through each user in the CSV and set the phone number property

foreach ($user in $userList) {

    $UserPrincipalName = $user.UserPrincipalName # Assuming the CSV has a column named "Username"

    $ManagerPrincipalName = $user.ManagerPrincipalName

    $Title = $user.Title

    $Street = $user.Street

    $City = $user.City

    $State = $user.State

    $Zip = $user.zip

    $OfficePhone = $user.OfficePhone

    # Check if the user exists in Active Directory

    if (Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName} -Properties Manager,Title,Street,City,State,PostalCode,OfficePhone) {

        #Manager
        try{

            $ADUser = Get-ADUser -Filter "UserPrincipalName -eq '$UserPrincipalName'" -SearchBase 'DC=FST,DC=local'

            $ADManager = Get-ADUser -Filter "UserPrincipalName -eq '$ManagerPrincipalName'" -SearchBase 'DC=FST,DC=local'

            Set-ADUser -Identity $ADUser -Manager $ADManager

            Write-Verbose -Message "-Manager updated for user: $UserPrincipalName" -Verbose

        }catch {

            Write-Verbose -Message "Failed to update -Manager for user: $UserPrincipalName - Error: $_"

        }

        

        #Title
        try{

        $ADUser = Get-ADUser -Filter "UserPrincipalName -eq '$UserPrincipalName'" -SearchBase 'DC=FST,DC=local'

        Set-ADUser -Identity $ADUser -Title $Title

        Write-Verbose -Message "-Title updated for user: $UserPrincipalName" -Verbose

        }catch {

        Write-Verbose -Message "Failed to update -Title for user: $UserPrincipalName - Error: $_" -Verbose

        }

        #Street Adress
        try {

            $ADUser = Get-ADUser -Filter "UserPrincipalName -eq '$UserPrincipalName'" -SearchBase 'DC=FST,DC=local'

            Set-ADUser -Identity $ADUser -StreetAddress $Street

            Write-Verbose -Message "-StreetAdress updated for user: $UserPrincipalName" -Verbose

            }catch {

            Write-Verbose -Message "Failed to update -StreetAdress for user: $UserPrincipalName - Error: $_" -Verbose

            }

        #City
        try {

            $ADUser = Get-ADUser -Filter "UserPrincipalName -eq '$UserPrincipalName'" -SearchBase 'DC=FST,DC=local'

            Set-ADUser -Identity $ADUser -City $City

            Write-Verbose -Message "-City updated for user: $UserPrincipalName" -Verbose

            }catch {

            Write-Verbose -Message "Failed to update -City for user: $UserPrincipalName - Error: $_" -Verbose

            }

        #State
        try {

            $ADUser = Get-ADUser -Filter "UserPrincipalName -eq '$UserPrincipalName'" -SearchBase 'DC=FST,DC=local'

            Set-ADUser -Identity $ADUser -State $State

            Write-Verbose -Message "-State updated for user: $UserPrincipalName" -Verbose

            }catch {

            Write-Verbose -Message "Failed to update -State for user: $UserPrincipalName - Error: $_" -Verbose

            }

        #PostalCode
        try {

            $ADUser = Get-ADUser -Filter "UserPrincipalName -eq '$UserPrincipalName'" -SearchBase 'DC=FST,DC=local'

            Set-ADUser -Identity $ADUser -PostalCode $Zip

            Write-Verbose -Message "-PostalCode updated for user: $UserPrincipalName" -Verbose

            }catch {

            Write-Verbose -Message "Failed to update -PostalCode for user: $UserPrincipalName - Error: $_" -Verbose

            }


        #OfficePhone Update
        try {

        $ADUser = Get-ADUser -Filter "UserPrincipalName -eq '$UserPrincipalName'" -SearchBase 'DC=FST,DC=local'

        Set-ADUser -Identity $ADUser -OfficePhone $OfficePhone

        Write-Verbose -Message "Office Phone updated for user: $UserPrincipalName" -Verbose

        }catch {

        Write-Verbose -Message "Failed to update -Officephone for user: $UserPrincipalName - Error: $_" -Verbose

        }

    }else {

        Write-Verbose -Message "User not found in Active Directory: $UserPrincipalName" -Verbose

        }
}

Stop-Transcript