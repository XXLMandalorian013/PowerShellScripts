    #ReadMe
<#

OneDrive-Force-Sync.ps1


.DESCRIPTION

Restarts Win 11 OneDrive Sync. 


.Notes

Restarts the OneDrive SyncServer. I had gone down the rabbit hole of if the OneDrive Sync Service was not running to start it but the only way to do so was
to kill OneDrive and start it again. Note, OneDrive MUST be started in an unelevated terminal with Start-Process else it will GUI display an error stating that. When
OneDrive is stated from an unelevated terminal, File Explorer would then start and I feel users would think they got hacked. Going to leave well enough alone on starting OneDrive.


.INPUTS

None.


.OUTPUTS

OneDrive Win11 Sync Service Restart
VERBOSE: OneDrive-Force-Sync.ps1 script starting...written by DAM, last modified on 2024-02-015

Status   Name               DisplayName                           
------   ----               -----------                           
Stopped  FileSyncHelper     FileSyncHelper                        
VERBOSE: Restarting FileSyncHelper
Running  FileSyncHelper     FileSyncHelper   

#>

#Region Start-Script
#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    $ScriptName = "OneDrive-Force-Sync.ps1"
    $ScriptAuthor = "DAM"
    $ModifiedDate = "2024-02-015"
    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate"
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}
#Restarts Win 11 OneDrive Sync.
function Restart-OneDriveSyncWin11 {
    #Restarts the OneDrive Sync Servics.
    try {
        Get-Service -Name "FileSyncHelper"
        Write-Verbose -Message "Restarting FileSyncHelper" -Verbose
        Restart-Service -Name "FileSyncHelper"
        Start-Sleep -Seconds 10
        Get-Service -Name "FileSyncHelper"
    }
    catch {
        Write-Verbose -Message "$Error[0]" -Verbose
    }
}
#Letting the user know what is starting.
Start-ScriptBoilerplate
#Restarts Win 11 OneDrive Sync.
Restart-OneDriveSyncWin11
#EndRegion

