#ReadMe
<#
Install-Terminal-AppX-64Bit-v1.20.11271.0.ps1
.SYNOPSIS
Manually installs the AppX version os Windows Terminal. 
.Notes
Terminal manually installed does not get automatically updated and will need to be uninstalled and reinstalled manually to get the latest versions.
.INPUTS
None.
.OUTPUTS
System.String.
VERBOSE: Install-Terminal-AppX-64Bit-v1.20.11271.0.ps1 script starting...written by DAM 2024-05-25, last modified
Never.
VERBOSE: The terminal is running as an Administrator...Continuing script...
VERBOSE: Creating C:\TerminalFiles...
VERBOSE: Downloading Microsoft.VCLibs.x86.14.00.Desktop.appx...
VERBOSE: Downloaded Microsoft.VCLibs.x86.14.00.Desktop.appx...
VERBOSE: Installing Microsoft.VCLibs.x86.14.00.Desktop.appx...
VERBOSE: Microsoft.VCLibs.x86.14.00.Desktop.appx Installed...
VERBOSE: Downloading microsoft.ui.xaml.2.8.6.nupkg...
VERBOSE: Downloaded microsoft.ui.xaml.2.8.6.nupkg...
VERBOSE: Renaming download...
VERBOSE: Unzipping download...
VERBOSE: Unzip complete...
VERBOSE: Installing microsoft.ui.xaml.2.8.6.zip...
VERBOSE: microsoft.ui.xaml.2.8.6.zip Installed...
VERBOSE: Downloading Microsoft.WindowsTerminal_1.20.11271.0_8wekyb3d8bbwe.msixbundle...
VERBOSE: Downloaded Microsoft.WindowsTerminal_1.20.11271.0_8wekyb3d8bbwe.msixbundle...
VERBOSE: Installing Microsoft.WindowsTerminal_1.20.11271.0_8wekyb3d8bbwe.msixbundle...
VERBOSE: Installed Microsoft.WindowsTerminal_1.20.11271.0_8wekyb3d8bbwe.msixbundle...
VERBOSE: Removing C:\TerminalFiles...
VERBOSE: Removed C:\TerminalFiles...
#>
#Region Start-Script
#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    param (
        $ScriptName = "Install-Terminal-AppX-64Bit-v1.20.11271.0.ps1",
        $ScriptAuthor = "DAM",
        $WrittenDate = "2024-05-25",
        $ModifiedDate = "Never",
        $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor $WrittenDate, last modified $ModifiedDate."
    )
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}
#Checks to see if the terminal is running as an administrator.
function Test-TerminalElevation {
    #Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
    }else {
        Write-Verbose -Message "The terminal is running as an Administrator...Continuing script..." -Verbose
    }
}
#TMP folder
$TMP = "TerminalFiles"
#Download Location
$DownloadLocation = "C:\$TMP"
#Creates a folder to hold the file downloads.
function New-FolderCreation {
    try {
        Write-Verbose -Message "Creating $DownloadLocation..." -Verbose
        New-Item -ItemType "directory" -Path "$DownloadLocation"
    }
    catch {
        Write-Verbose -Message "$Error[0]" -Verbose
    }
}
#Microsoft.VCLibs Install
function Install-VCLibs {
    param (
        $URI = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx",
        $DLName = "Microsoft.VCLibs.x86.14.00.Desktop.appx",
        $Outfile = "$DownloadLocation/$DLName"
    )
    try {
        Write-Verbose -Message "Downloading $DLName..." -Verbose
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri "$URI" -outfile "$Outfile"
        Write-Verbose -Message "Downloaded $DLName..." -Verbose
    }
    catch {
        Write-Verbose -Message "$Error[0]" -Verbose
    }
    try {
        Write-Verbose -Message "Installing $DLName..." -Verbose
        Add-AppxPackage "$Outfile"
        Write-Verbose -Message "$DLName Installed..." -Verbose
    }
    catch {
        Write-Verbose -Message "$Error[0]" -Verbose
    }
}
#Microsoft.UI.Xaml Install
function Install-MicrosoftUIXaml {
    param (
        $URI = "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.6",
        $DLName = "microsoft.ui.xaml.2.8.6.nupkg",
        $Outfile = "$DownloadLocation/$DLName",
        $DLNewName = "microsoft.ui.xaml.2.8.6.zip"
    )
    try {
        Write-Verbose -Message "Downloading $DLName..." -Verbose
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri "$URI" -outfile "$Outfile"
        Write-Verbose -Message "Downloaded $DLName..." -Verbose
    }
    catch {
        Write-Verbose -Message "$Error[0]" -Verbose
    }
    try {
        Write-Verbose -Message "Renaming download..." -Verbose
        Rename-Item -Path "$Outfile" -NewName "$DLNewName"
    }
    catch {
        Write-Verbose -Message "$Error[0]" -Verbose
    }
    try {
        Write-Verbose -Message "Unzipping download..." -Verbose
        Expand-Archive -Path "$DownloadLocation\$DLNewName" -DestinationPath "$DownloadLocation"
        Write-Verbose -Message "Unzip complete..." -Verbose
    }
    catch {
        Write-Verbose -Message "$Error[0]" -Verbose
    }
    try {
        Write-Verbose -Message "Installing $DLNewName..." -Verbose
        $appxSearch = Get-ChildItem -Path "C:\TerminalFiles\tools\AppX\x64\Release"
        $appxRename = $appxSearch.Name
        Add-AppxPackage "$DownloadLocation\tools\AppX\x64\Release\$appxRename"
        Write-Verbose -Message "$DLNewName Installed..." -Verbose
    }
    catch {
        Write-Verbose -Message "$Error[0]" -Verbose
    }
}
#Terminal Install
function Install-Terminal {
    param (
        $URI = "https://github.com/microsoft/terminal/releases/download/v1.20.11271.0/Microsoft.WindowsTerminal_1.20.11271.0_8wekyb3d8bbwe.msixbundle",
        $DLName = "Microsoft.WindowsTerminal_1.20.11271.0_8wekyb3d8bbwe.msixbundle",
        $Outfile = "$DownloadLocation/$DLName"
    )
    try {
        Write-Verbose -Message "Downloading $DLName..." -Verbose
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri "$URI" -outfile "$Outfile"
        Write-Verbose -Message "Downloaded $DLName..." -Verbose
    }
    catch {
        Write-Verbose -Message "$Error[0]" -Verbose
    }
    try {
        Write-Verbose -Message "Installing $DLName..." -Verbose
        Add-AppxPackage "$Outfile"
        Write-Verbose -Message "Installed $DLName..." -Verbose
    }
    catch {
        Write-Verbose -Message "$Error[0]" -Verbose
    }
}
#TMP Cleanup
function Remove-TMP {
    try {
        Write-Verbose -Message "Removing $DownloadLocation..." -Verbose
        Start-Sleep -Seconds 5
        Remove-Item "$DownloadLocation" -Recurse -Force
        Write-Verbose -Message "Removed $DownloadLocation..." -Verbose
    }
    catch {
        Write-Verbose -Message "$Error[0]" -Verbose
    }
}
#Function Calls
$Functions = @(
    #Letting the user know what is starting.
    Start-ScriptBoilerplate
    #Checks to see if the terminal is running as an administrator.
    Test-TerminalElevation
    #Creates a folder to hold the file downloads.
    New-FolderCreation
    #Microsoft.VCLibs Install
    Install-VCLibs
    #Microsoft.UI.Xaml Install
    Install-MicrosoftUIXaml
    #Terminal Install
    Install-Terminal
    #TMP Cleanup
    Remove-TMP
)
$Functions
#EndRegion
