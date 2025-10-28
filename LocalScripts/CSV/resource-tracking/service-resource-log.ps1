#ReadMe
<#
service-resource-log.ps1
.SYNOPSIS
Tracks a programs resource usage for CPU and RAM and logs it to a CSV file.
.INPUTS
None.
.OUTPUTS
System.String,
#>
#Script
#Vars
#TMP install folder location.
$TMPFolderLocation = "C:"
#TMP install folder.
$TempFolder = "TMP-99"
#Log file name.
$FileName = "Log.csv"
#Gets the date.
$DateDay = (Get-Date -Format "MM-dd-yyyy")
#Gets the time.
$DateTime = (Get-Date -Format "HH:mm")
#.csv headers defined.
$Headers= "time,process,cpu,ram-working,ram-private"
#Full path to the CSV
$FullPath = "$TMPFolderLocation\$TempFolder\$DateDay-$FileName"
#Region Start-Script
#Script Boiler Plate.
function Start-ScriptBoilerPlate {
    param (
        #Script Name
        $ScriptName = "service-resource-log.ps1",
        #Script Author
        $ScriptAuthor = "Written by DAM on 2025-10-28"
    )
    #Script Introduction
    Write-Verbose -Message "$ScriptName $ScriptAuthor" -Verbose 
}
#Checks to see if the terminal is running as an administrator.
function Test-TerminalElevation {
    #Checks if the terminal is running as admin/elevated as Invoke-WebRequest will not run without it.
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
        Exit
    }else {
        Write-Verbose -Message "The terminal is running as an Administrator...Continuing script..." -Verbose
    }
}
#Creates the TMP folder if it does not already exists.
function New-TMPFolder {
    #Creates the TMP folder if it does not already exists.
    if (Test-Path -Path "$TMPFolderLocation\$TempFolder") {
        Write-Verbose -Message "'$TMPFolderLocation\$TempFolder' exists...continuing script..." -Verbose
    }else {
        Write-Verbose -Message "'$TMPFolderLocation\$TempFolder' does not exists...creating temp folder..." -Verbose
        New-Item -Path "$TMPFolderLocation\$TempFolder" -ItemType "Directory"
    }
}
#Creates the log file if it does not already exists.
function New-LogFile {
    #Creates the log file if it does not already exists.
    if (Test-Path -Path "$TMPFolderLocation/$TempFolder/$DateDay-$FileName") {
        Write-Verbose -Message "Log file '$TMPFolderLocation/$TempFolder' exists...continuing script..." -Verbose
    }else {
        Write-Verbose -Message "Log file '$TMPFolderLocation/$TempFolder' does not exists...creating log file..." -Verbose
        New-Item -Path "$TMPFolderLocation/$TempFolder" -Name "$DateDay-$FileName" -ItemType "File"
        #Adds headers.
        Write-Verbose -Message "Adding headers to log file..." -Verbose
        Add-Content -Path $FullPath -Value $Headers
    }
}
#Logs the process metrics to the CSV file.
function Get-ProcessMetrics {
    #Process name.
    $ProcessName = "SophosOsquery"
    #Get the process object.
    $Process = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
    if ($Process) {
        Write-Verbose -Message "Process '$ProcessName' found...extracting metrics..." -Verbose
        #Extract metrics
        $CPU = [math]::Round($Process.CPU, 2)
        $RAMWorking = [math]::Round($Process.WorkingSet64 / 1MB, 2)
        $RAMPrivate = [math]::Round($Process.PrivateMemorySize64 / 1MB, 2)
        # Construct CSV line
        $CsvLine = "$DateTime,$ProcessName,$CPU,$RAMWorking,$RAMPrivate"
        # Full path to CSV
        $FullPath = "$TMPFolderLocation\$TempFolder\$DateDay-Log.csv"
        # Append to CSV
        Add-Content -Path $FullPath -Value $CsvLine
        # Display verbose message
        Write-Verbose -Message "Logged: $CsvLine" -Verbose
    }else {
        Write-Warning "Process '$ProcessName' not found."
    }
}
#Script Boiler Plate.
Start-ScriptBoilerPlate
#Checks to see if the terminal is running as an administrator.
Test-TerminalElevation
#Creates the TMP folder if it does not already exists.
New-TMPFolder
#Creates the log file if it does not already exists.
New-LogFile
#Logs the process metrics to the CSV file.
Get-ProcessMetrics
#EndRegion


