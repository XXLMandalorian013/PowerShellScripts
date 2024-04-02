#ReadMe
<#
Visual-C++-redistributable-14.28.29325.ps1

.SYNOPSIS


.Notes

.INPUTS

None.

.OUTPUTS

System.String,


.LINK

[Write-Verbose](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-verbose?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.3)

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3)

[about_Try_Catch_Finally](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.3)

[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3)

[about_Operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)

[about_Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.3)

[Invoke-WebRequest](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.3)

[msiexec](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/msiexec)

[about_Do](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.3)

[Remove-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.3)

[C++ Installer Switch Help](https://learn.microsoft.com/en-us/cpp/windows/redistributing-visual-cpp-files?view=msvc-170#command-line-options-for-the-redistributable-packages)

[C++ Installer Switch Help](https://learn.microsoft.com/en-us/cpp/windows/redistributing-visual-cpp-files?view=msvc-170#command-line-options-for-the-redistributable-packages)

[C++ Installer DL](https://www.npackd.org/p/com.microsoft.VisualCPPRedistributable/14.28.29325)

#>

#Script

#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
}
#Script Boilerplate
function Start-ScriptBoilerPlate {
    [CmdletBinding()]
    param (
        #Script Name
        $ScriptName = 'Visual-C++-redistributable-14.28.29325.ps1',
        #Script Author
        $ScriptAuthor = 'Written by DAM on 2024-03-15'
    )
    #Script Introduction
    Write-Verbose -Message "$ScriptName $ScriptAuthor" -Verbose 
}
#Installs Accent's Cloud Contact Center ZAC
function Install-CRedist {
    param(
        #Download Link
        $URI = 'https://download.visualstudio.microsoft.com/download/pr/8ecb9800-52fd-432d-83ee-d6e037e96cc2/50A3E92ADE4C2D8F310A2812D46322459104039B9DEADBD7FDD483B5C697C0C8/VC_redist.x86.exe',
        #Full name of the installer.
        $InstallerName = 'VC_redist.x86.exe',
        #Out-File location.
        $OutFile = "C:\$InstallerName"
    )
    try {
            #Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
            $ProgressPreference = 'SilentlyContinue'
            Write-Verbose -Message "Downloading .exe installer for $InstallerName..." -Verbose
            Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing
        }catch {
            Write-Verbose -Message"$Error[0]" -Verbose
            Write-Verbose -Message"$InstallerName may not match what is being download anymore?" -Verbose
            Write-Verbose -Message"Invoke-WebRequest is not supported on Win 7..." -Verbose
        }
        #Installs the Program from URI.
        try {
            Write-Verbose -Message "Installing $InstallerName" -Verbose
            Start-Process -filepath "$OutFile" -ArgumentList "/install", "/quiet", "/norestart" -Passthru | Wait-Process
        }catch {
            Write-Verbose -Message "$Error[0]" -Verbose
        }
}

Start-ScriptBoilerPlate

Install-CRedist

