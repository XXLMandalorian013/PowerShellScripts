    #ReadMe
<#
    
.SYNOPSIS

    Adds a file name extension to a supplied name.


.DESCRIPTION
        
    To run Security and Compliance Center CMDLets,

    1. You must be connected to an the ExchangeOnlineManagment Modile 2.0.5 or later.

    2. You must then connect to the SCC via Connect-IPPSSession.

    3. Once these connections are established, the New-ComplianceSearch creates the peramiters for the search.

    4. Start-ComplianceSearch does just that, starts the search based on the New-ComplianceSearch peramiters.

    5. The Get-ComplianceSearch then checks if the ComplianceSearch has finished. 
    
    
.Notes

   
    

.PARAMETER Name
        
    Specifies the file name.

    
.PARAMETER Extension
        
    Specifies the extension. "Txt" is the default.


.INPUTS
        
    None. You cannot pipe objects to Add-Extension.


.OUTPUTS
        
    System.String. Add-Extension returns a string with the extension or file name.


.EXAMPLE
        
    PS> extension "File" "doc"
    File.doc


.LINK
        
    https://learn.microsoft.com/en-us/powershell/module/exchange/get-managementrole?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/module/exchange/new-compliancesearch?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/exchange/connect-to-scc-powershell?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/module/exchange/new-compliancesearch?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/module/exchange/start-compliancesearch?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/module/exchange/get-compliancecase?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/module/exchange/get-compliancesearchaction?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/module/exchange/new-compliancesearchaction?view=exchange-ps


#>

#Script 


param (

[Parameter(Mandatory,HelpMessage='Name the search.')]
[string]$SearchName,


[Parameter(Mandatory,HelpMessage='Type the user email address for a full backup or email subject.')]
[string]$EXLocation

)


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


#Create Compliance Search peramiters

New-ComplianceSearch -Name "$SearchName" -ExchangeLocation "$EXLocation"


#Runs the New-ComplianceSearch CMDLet.

Start-ComplianceSearch -Identity "$SearchName"


#Start Exporting the Compliance Search

New-ComplianceSearchAction "$SearchName" -Export -Format Fxstream


#Check if Compliance Search is done and if so, it starts exporting it.

do { 
    Start-Sleep -Seconds 60
    $CSStatus = (Get-ComplianceSearch -Identity $SearchName).Status
    if ($CSStatus -ne "Completed") {
        Write-Output "Status for $SearchName is $CSStatus. Checking again in 1 minute..."
    }
} 
Until ($CSStatus -eq "Completed")

Write-Output "$SearchName completed...Starting Export"

Start-Sleep -Seconds 10

New-ComplianceSearchAction "$SearchName" -Export -Format Fxstream


#Check if Compliance Search is done and if so, it opens the URl to the MS Compliance Center in Edge as ClickOnce is required to download w/ the MS export tool upon first download and use.

do { 
    Start-Sleep -Seconds 60
    $CAStatus = (Get-ComplianceSearchAction -Identity $SearchName).Status
    if ($CAStatus -ne "Completed") {
        Write-Output "Status for $SearchName is $CAStatus. Checking again in 1 minute..."
    }
} 
Until ($CAStatus -eq "Completed")


Start-Process -FilePath "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -ArgumentList "https://compliance.microsoft.com/contentsearchv2?viewid=export"



   
 








