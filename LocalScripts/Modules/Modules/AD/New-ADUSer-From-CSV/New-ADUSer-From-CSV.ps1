

Import-Csv -Path "$Global:CSVPath" -Header 'DeviceName', 'IPAddress' | ForEach-Object {
        
    Set-ADUser -UserPrincipalName
    
    New-NpsRadiusClient -Address $_.IPAddress -Name $_.DeviceName -VendorName $Global:VendorName -SharedSecret $Global:SharedSecret
        }


#Transcript date.
$Global:Date = Get-Date -Format "MM-dd-yyyy"

#CSV import location.
$Global:CSVPath = 'C:\Scripts\Ad-Managers\Data\AD-CSV-Import'

#CSV Import variable.
$Global:CSVImport = Import-Csv -Path "$Global:CSVPath"

#Transscript path.
Start-Transcript -Path "C:\Scripts\Ad-Managers\log_$date.log"

#Import Module
Import-Module ActiveDirectory

foreach ($line in $Global:CSVImport) {
    UserPrincipalName = $line.UserPrincipalName
}



Import-Module ActiveDirectory

$Users = Import-Csv -Path "C:\Scripts\Ad-Managers\Data\AD-CSV-Import"

$Global:CitySwitch = switch ($City) {
    "Chicago" {
        $OU = "OU=Chicago,OU=Employees,DC=domain,DC=com"
    }
    "Miami" {
        $OU = "OU=Miami,OU=Employees,DC=domain,DC=com"
    }
    "Boston" {
        $OU = "OU=Boston,OU=Employees,DC=domain,DC=com"
    }
    default {
        $OU = "CN=Users,DC=domain,DC=com"
    }
}

foreach ($User in $Users) {
    $UserPrincipalName = $User.UserPrincipalName
    $Manager = $User.ManagerPrncipalName
    $Title = $User.Title
    $StreetAddress = $User.Street
    $City = $User.City
    $State = $User.State
    $PostalCode = $User.Zip
    $OfficePhone = $User.OfficePhone

        New-ADUser -Path "$Global:CitySwitch" -UserPrincipalName "$UserPrincipalName" -Manager "$Manager" -Title "$Title" -StreetAddress "$StreetAddres" -City "$City" -State "$State" -PostalCode "$PostalCode" -OfficePhone "$OfficePhone"
}






