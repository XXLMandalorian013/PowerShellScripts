    #ReadMe
<#
    
.SYNOPSIS

Backups a users EXO mailbox.


.DESCRIPTION
        
1. Asks you to name the search and the users email.

2. Makes sure you are are running the script administrativly in PS 7.X.X and are connected to EXO and the SCC.

3. Creates a Compliance Search and starts it, based on step 1.s peramiters.

4. Check if Compliance Search is done and if so, it starts exporting it.

4. Check if Compliance Search Action exporting is done, if so it moves onto if the .pst is ready for download.

5. Checks if the .pst is reaedy to be downloaded, if so it opens the URl to the MS Compliance Center in Edge as ClickOnce is required to download w/ the MS export tool upon first download and use.


.Notes

As EXOV3 only work in PS 7.X.X this script run only in PS 7.X.X. 

.INPUTS
        
System.String. 
    
SearchName: User-Mailbox-Export
EXLocation: email@domain.com


.OUTPUTS
        
System.String.

This script is running in 7.2.6.
Your are not connected to ExchangeOnline...Connecting
Your are not connected to the SCC...Connecting


Name               RunBy JobEndTime Status
----               ----- ---------- ------
User-Mailbox-Export                  NotStarted


Status for User-Mailbox-Export is Starting. Checking again in 1 minute...


User-Mailbox-Export completed...Starting Export


Status for User-Mailbox-Export is Starting. Checking again in 1 minute...
Status for User-Mailbox-Export is Starting. Checking again in 1 minute...
Status for User-Mailbox-Export is Starting. Checking again in 1 minute...


User-Mailbox-Export is Completed opening the SCC Export URL in Edge, please seleted it and manually download it. 
If this is the first time running this, you will be prompted to download the eDescovery Export Tool.

.LINK
        
https://learn.microsoft.com/en-us/powershell/module/exchange/get-managementrole?view=exchange-ps

https://learn.microsoft.com/en-us/powershell/module/exchange/new-compliancesearch?view=exchange-ps

https://learn.microsoft.com/en-us/powershell/exchange/connect-to-scc-powershell?view=exchange-ps

https://learn.microsoft.com/en-us/powershell/module/exchange/new-compliancesearch?view=exchange-ps

https://learn.microsoft.com/en-us/powershell/module/exchange/start-compliancesearch?view=exchange-ps

https://learn.microsoft.com/en-us/powershell/module/exchange/get-compliancecase?view=exchange-ps

https://learn.microsoft.com/en-us/powershell/module/exchange/get-compliancesearchaction?view=exchange-ps

https://learn.microsoft.com/en-us/powershell/module/exchange/new-compliancesearchaction?view=exchange-ps

https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.2

#>


#Script 

#Prompting Perameters that asks you to name the search and the users email.

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


#Check if Compliance Search is done and if so, it starts exporting it.

do { 
    Start-Sleep -Seconds 60
    $CSStatus = (Get-ComplianceSearch -Identity "$SearchName").Status
    if ($CSStatus -ne "Completed") {
        Write-Output "Status for $SearchName is $CSStatus. Checking again in 1 minute..."
    }
} 
Until ($CSStatus -eq "Completed")

Write-Output "$SearchName completed...Starting Export"

Start-Sleep -Seconds 10

New-ComplianceSearchAction "$SearchName" -Export -Format Fxstream


#Check if Compliance Search Action exporting is done, if so it moves onto if the .pst is ready for download.

do { 
    Start-Sleep -Seconds 60
    
    $CASName = Get-ComplianceSearchAction | Select-Object -ExpandProperty Name -Last 1
    
    $CAStatus = (Get-ComplianceSearchAction -Identity "$CASName").Status 
    
    if ($CAStatus -ne "Completed" ) {
        
        Write-Host "Status for $SearchName is $CAStatus. Checking again in 1 minute..."

    }
} 
Until ($CAStatus -eq "Completed")

Write-Host "$SearchName is $CAStatus, getting download ready."


#Checks if the .pst is reaedy to be downloaded, if so it opens the URl to the MS Compliance Center in Edge as ClickOnce is required to download w/ the MS export tool upon first download and use.

do { 
    Start-Sleep -Seconds 60
    
    $TodaysDate = Get-Date -Format "yyyy-MM-dd"

    Get-ComplianceSearchAction -Identity "$CASName" | Select-Object 'JobEndTime'

    if ("$CASName" -ne "$TodaysDate") {
    
        Write-Host 'Export data is being prepared for download...Please wait.  Checking again in 1 minute...'

    }
}
Until ("$CASName" -eq "$TodaysDate")

Start-Sleep -Seconds 10

Write-Host "$SearchName is ready for downloading, opening the SCC Export URL in Edge, please seleted it and manually download it." 

Write-Host "If this is the first time running this, you will be prompted to download the eDescovery Export Tool."

Start-Process -FilePath "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -ArgumentList "https://compliance.microsoft.com/contentsearchv2?viewid=export"






   
 








