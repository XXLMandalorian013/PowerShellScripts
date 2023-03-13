    #ReadMe
<#

Write-ErrorLog.ps1

.SYNOPSIS

A function that captures errors in a script and outputs it to a .txt.
    
.DESCRIPTION
        
Writes-Error to the console and creates a error log .txt captureing the issue. The script will stop and exit upon getting an error. 
Write everything in a Try/Catch and or Finally CMDLet to capture the error output.    
    
.Notes

Works in 7.X.X.

.INPUTS
        
None.

.OUTPUTS
        
Verbose.String, and .txt output of error per try catch.

    Directory: C:\

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----           3/13/2023  5:07 PM                Temp MitelConnect Installer
Write-ErrorLog:
Line |
   5 |      Write-ErrorLog -Text "Get-Buttz is not a know PS CMDLet."
     |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | Script error detected...script is ending...

.LINK

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3) 
        
[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3)

[New-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.3) 

[Get-Date](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.3)

[Write-Error](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-error?view=powershell-7.3)

[Out-File](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-file?view=powershell-7.3) 

#>

#Script


#Gloabal Variables

$ScriptName = "Test.ps1"

$TempInstallerPath = "C:\"

$InstallerFolderName = 'Temp MitelConnect Installer'

$OutFile = "$TempInstallerPath\$InstallerFolderName"

function Write-ErrorLog {
    [CmdletBinding ()]
    param (
        [string]$Text
    )
    New-Item -Path "$TempInstallerPath" -Name "$InstallerFolderName" -ItemType 'Directory' -ErrorAction SilentlyContinue

    $Entry = (Get-Date -Format "yyyy/MM/dd HH:mm dddd - ") + $Text

    Write-Error -Message "Script error detected...script is ending..."

    $Entry | Out-File -Path "$OutFile\$ScriptName-Error-Log-File.txt"

    Start-Sleep -Seconds 5

    Exit
}

#Test Try/Catch for error log function handling.
try {
    Get-Buttz -ErrorAction Stop
}
catch {
    Write-ErrorLog -Text "Get-Buttz is not a know PS CMDLet."
}

