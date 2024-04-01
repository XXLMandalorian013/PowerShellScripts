    #ReadMe
<#

URL-DownTime-Check
    
.SYNOPSIS

#Checks if the site is up with a 200 OK code.


.DESCRIPTION
        
Checks if the site is up with a 200 OK code. If not it exports a .csv with the date and the error.  
    
    
.Notes

Works in PS 5.1 and later.

.INPUTS
        
None.


.OUTPUTS
        
None.


.LINK
        
[Invoke-WebRequest](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.3) 

[Export-Csv](https://adamtheautomator.com/export-csv/) 

[Export-Csv](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-csv?view=powershell-7.3) 

[Get-Date](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.3)

[Everything you wanted to know about the if statement](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.3) 

#>

#Script

$ScriptName = 'URL-DownTime-Check'

$URL = 'https://google.com/'

$WebRequest = Invoke-WebRequest -Method Head -URI "$URL"

$Date = Get-Date -Format "dddd MM-dd-yyyy HH:mm K"

$CSVOutput = [pscustomobject]@{'Date' = $Date; 'Error' = $WebRequest.StatusDescription; 'StatusCode' = $WebRequest.StatusCode}


Write-Host "$ScriptName script starting...Written by DAM on 2023-01-23"


#Checks if the site is up with a 200 OK code.

if ($WebRequest.StatusDescription -eq 'OK') {
    
}else {

    $CSVOutput | Export-Csv -Path "\\Server\Folder\Error.csv" 

}


