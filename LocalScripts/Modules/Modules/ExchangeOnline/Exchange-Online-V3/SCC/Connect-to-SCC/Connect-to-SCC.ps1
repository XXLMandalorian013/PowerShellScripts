    #ReadMe
<#

.DESCRIPTION
        
    Connects to the Security and Compliance Center.  
    
    
.Notes

    7.X.X and later.
    

#>

#Script



#Exchange Online module 2.0.5 (V2) and newer requires PS 7.X.X.


if ($PSVersionTable.PSVersion.Major -eq 7) {
		
	Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
} 

else {
	
    Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 7.X.X...Ending Script" -WarningAction Inquire
		
	Start-Sleep -Seconds 3

	Exit
}


#Am I connected to ExchangeOnlinehe? Its required to be connected to the EXO before connecting to the SCC.

$PSSessionsName = Get-ConnectionInformation | Select-Object -Property "Name"

if ("$PSSessionsName" -match 'ExchangeOnline') 
{

}   
else
{
    Write-Host "Your are not connected to ExchangeOnline...Connecting"
    
    Connect-ExchangeOnline
} 


#Am I connected to the Security and Compliance Center?

$SCCConnection = Get-PSSession | Select-Object -Property "ConnectionURI"

if ("$SCCConnection" -match 'compliance.protection') 
{
    
}   
else
{
    Write-Host "Your are not connected to the SCC...Connecting"

    Connect-IPPSSession
}
