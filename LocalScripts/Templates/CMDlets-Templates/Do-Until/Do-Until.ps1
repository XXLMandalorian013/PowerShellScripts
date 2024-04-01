    #ReadMe
<#


    .SYNOPSIS
    
        

    .Notes

        Works in 

    .Link

    [Do-Until Online Version](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.2)     
#>  


#Script


#Check if Compliance Search is done and if so, it starts exporting it.

do { 
    Start-Sleep -Seconds 180
    $CSStatus = (Get-ComplianceSearch -Identity "$SearchName").Status
    if ($CSStatus -ne "Completed") {
        Write-Output "Gathering users data for $SearchName is $CSStatus...Please wait. Checking again in 3 minutes..."
    }
} 
Until ($CSStatus -eq "Completed")

Write-Output "ComplianceSearch $SearchName completed...Starting Export"

Start-Sleep -Seconds 10

New-ComplianceSearchAction "$SearchName" -Export -Format Fxstream


#Check if Compliance Search Action exporting is done, if so it moves onto if the .pst is ready for download.

do { 
    Start-Sleep -Seconds 180
    
    $CASName = Get-ComplianceSearchAction | Select-Object -ExpandProperty Name -Last 1
    
    $CAStatus = (Get-ComplianceSearchAction -Identity "$CASName").Status 
    
    if ($CAStatus -ne "Completed") {
        
        Write-Host "Scheduling for $SearchName is $CAStatus...Please wait. Checking again in 3 minutes..."

    }
} 
Until ($CAStatus -eq "Completed")

Write-Host "Scheduling for $SearchName is $CAStatus, and the export key has been generated...Getting the download ready."


#Checks if the .pst is reaedy to be downloaded, if so it opens the URl to the MS Compliance Center in Edge as ClickOnce is required to download w/ the MS export tool upon first download and use.

do { 
    Start-Sleep -Seconds 300
    
    $TodaysDate = Get-Date -Format "MM/dd/yyyy"

    $CASJobEndTime = Get-ComplianceSearchAction -Identity "$CASName" | Select-Object 'JobEndTime'

    if ("$CASJobEndTime" -ne "$TodaysDate") {
    
        Write-Host 'Export data is being prepared for download...Please wait.  Checking again in 5 minute...'
        
    }
}
Until ($CASJobEndTime -match "$TodaysDate")

Start-Sleep -Seconds 10

Write-Host "$SearchName is ready for downloading, opening the SCC Export URL in Edge, please seleted it and manually download it." 

Write-Host "If this is the first time running this, you will be prompted to download the eDescovery Export Tool."

Start-Process -FilePath "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -ArgumentList "https://compliance.microsoft.com/contentsearchv2?viewid=export"