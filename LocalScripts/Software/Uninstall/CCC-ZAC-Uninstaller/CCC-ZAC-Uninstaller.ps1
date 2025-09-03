#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
}
#Script Boilerplate
function Start-ScriptBoilerPlate {
    [CmdletBinding()]
    param (
        #Script Name
        $ScriptName = 'Zac-Uninstaller.ps1',
        #Script Author
        $ScriptAuthor = 'Written by DAM on 2025-09-03'
    )
    #Script Introduction
    Write-Verbose -Message "$ScriptName $ScriptAuthor" -Verbose 
}
#Tries to uninstall zac.exe 
function Uninstall-Zac {
    param (
        #Vars
    #Program Path when its installed.
    $ProgramPath = 'C:\Program Files (x86)\Zultys\ZAC\zac.exe',
    #Download Link, cut off to have the installed version amened on the path.
    $URI = 'https://mirror.zultys.biz/ZAC',
    #Out-File location.
    $OutFile = "C:"
    )
    #Tries to uninstall zac.exe.    
    $ExsistingInsatll = Test-Path -Path "$ProgramPath"
        if ($ExsistingInsatll -match 'False') {
            Write-Verbose -Message "$InstallerName is already uninstalled..." -Verbose
        }else {
            try {
                #Grabs the installed version as the uninstaller only works with the same installed version for cli uninstalls.
                Write-Verbose -Message "Grabbing installed version to DL the right uninstaller version..." -Verbose
                (Get-Item "C:\Program Files (x86)\Zultys\ZAC\zac.exe").VersionInfo.FileVersion
            }catch {
                Write-Verbose -Message"$Error[0]" -Verbose
            }
        }
        #Downloads the required exe.
        try {
            # TLS 1.2 ensured for download.
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $InstalledVersion = (Get-Item "C:\Program Files (x86)\Zultys\ZAC\zac.exe").VersionInfo.FileVersion
            #Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
            $ProgressPreference = 'SilentlyContinue'
            Write-Verbose -Message "Downloading uninstaller $InstallerName..." -Verbose
            Invoke-WebRequest -URI "$URI/ZAC_x64-$InstalledVersion.exe" -OutFile "$OutFile\ZAC_x64-$InstalledVersion.exe" -UseBasicParsing
        }catch {
            Write-Verbose -Message"$Error[0]" -Verbose
            Write-Verbose -Message"$InstallerName may not match what is being download anymore?" -Verbose
            Write-Verbose -Message"Invoke-WebRequest is not supported on Win 7..." -Verbose
        }
        #Kills the running program.
        try {
            Write-Verbose -Message "Uninstalling $InstallerName" -Verbose
            taskkill /f /im zac.exe
            Start-Sleep -Seconds 8
        }catch {
            Write-Verbose -Message "$Error[0]" -Verbose
        }
            #Uninstalls the program, per the installer.
        try {
            Write-Verbose -Message "Uninstalling $InstallerName" -Verbose
            $InstallerPath = "$OutFile\ZAC_x64-$InstalledVersion.exe"
            $Arguments = "/x /s /v/qn"
            Start-Process -FilePath $InstallerPath -ArgumentList $Arguments
            #Give the uninstaller a second
            Start-Sleep -Seconds 20
        }catch {
            Write-Verbose -Message "$Error[0]" -Verbose
        }
        #Ininstall check and TEMP file delete.
        try {
            do { 
                $TestPath = Test-Path -Path "$ProgramPath"
                if ($TestPath -match 'True') {
                Write-Verbose -Message "$InstallerName uninstaller is running...Please wait" -Verbose
                Start-Sleep -Seconds 5
            }
        }Until ($TestPath -match 'False')
            Write-Verbose -Message "$InstallerName uninstalled!" -Verbose
            Start-Sleep -Seconds 10
            Write-Verbose -Message "$InstallerName removed" -Verbose
            Remove-Item "$OutFile"
    }catch {
        Write-Verbose -Message "$Error[0]" -Verbose
    }
}
#Script Boilerplate
Start-ScriptBoilerPlate
#Tries to uninstall zac.exe 
Uninstall-Zac
