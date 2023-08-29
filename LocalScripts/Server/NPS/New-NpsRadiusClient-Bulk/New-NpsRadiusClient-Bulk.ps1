    #ReadMe
<#

New-NpsRadiusClient-Bulk.ps1

.DESCRIPTION

Bulk import devices into a Radius/NPS server.  

.Notes

$Global:CSVPath should be changed acordinly to where the .csv is stored at.

$Global:VendorName should be the acual devices vendor name, unless not listed in the Radius/NPS server.

When plugging in the $Global:SharedSecret, this script is NEVER to be saved anywhere as plain text.

.INPUTS

None. Just change $Global:VendorName, $Global:SharedSecret, and $Global:CSVPath befor running.


.OUTPUTS

System.String. It will list the devices names as it imports them.

.LINK

[Import-Csv](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/import-csv?view=powershell-7.3)

[New-NpsRadiusClient](https://learn.microsoft.com/en-us/powershell/module/nps/new-npsradiusclient?view=windowsserver2022-ps)

[about_Foreach](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_foreach?view=powershell-7.3)

[about_Automatic_Variables](https://learn.microsoft.com/en-us/powershell/module/nps/new-npsradiusclient?view=windowsserver2022-ps)

#>

#Region Start-Script

#Global Variables

$Global:VendorName = 'RADIUS Standard'

$Global:SharedSecret = '???????'

$Global:CSVPath = 'C:\NPS-Devices-Test-CSV.csv'

Import-Csv -Path "$Global:CSVPath" -Header 'DeviceName', 'IPAddress' | ForEach-Object {
        New-NpsRadiusClient -Address $_.IPAddress -Name $_.DeviceName -VendorName $Global:VendorName -SharedSecret $Global:SharedSecret
        }

#EndRegion