    #ReadMe
<#

Write-Script-Steps.ps1

.SYNOPSIS

A function that captures each part of a scripts steps by outputs it to a .txt.
    
.DESCRIPTION
        
Writes verbosly to the console and creates a error log .txt captureing each compleated step of a script. 
Write everything in a Try/Catch and or Finally CMDLet to capture the error output.    
    
.Notes

Works in 7.X.X.

.INPUTS
        
None.

.OUTPUTS
        
Verbose.String, and .txt output of error per try catch.

VERBOSE: Logging Compleated Step

VERBOSE: Logging Compleated Step

.LINK

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3) 
        
[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3)

[New-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.3) 

[Get-Date](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.3)

[Add-Content](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-content?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.3)

[Out-File](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-file?view=powershell-7.3)

[Write-Verbose](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-verbose?view=powershell-7.3) 

#>

#Script


#Gloabal Variables

$ScriptName = "Write-Script-Steps.ps1"

$TempInstallerPath = "C:\"

$InstallerFolderName = 'Temp MitelConnect Installer'

$OutFile = "$TempInstallerPath\$InstallerFolderName"

#A function to log the steps of a script.
function Write-ScriptStep {
    [CmdletBinding ()]
    param (
        [string]$Text
    )

    $ExsitingStep = Test-Path -Path "$OutFile\$ScriptName-Log-File.txt"

    if ("$ExsitingStep" -eq 'False') {
        
        New-Item -Path "$TempInstallerPath" -Name "$InstallerFolderName" -ItemType 'Directory' -ErrorAction SilentlyContinue

        $Entry = (Get-Date -Format "yyyy/MM/dd HH:mm dddd - ") + $Text

        $Entry | Out-File -Path "$OutFile\$ScriptName-Log-File.txt"

        Write-Verbose -Message "Logging Compleated Step" -Verbose

    }else {

        Add-Content -Path "$OutFile\$ScriptName-Log-File.txt" -Value "$Text"

        Write-Verbose -Message "Logging Compleated Step" -Verbose
    }
}

#Test Try/Catch for steps log function handling.
try {
    Get-Process -ErrorAction Stop
    Write-ScriptStep -Text "Step 1 complete"
}
catch {
    Write-Error -Message "Check the above try syntax."
}

#Test Try/Catch for error log function handling.
try {
    Get-Process -ErrorAction Stop
    Write-ScriptStep -Text "Step 2 complete"
}
catch {
    Write-Error -Message "Check the above try syntax."
}

#Test Try/Catch for error log function handling.
try {
    Get-Process -ErrorAction Stop
    Write-ScriptStep -Text "Step 3 complete"
}
catch {
    Write-Error -Message "Check the above try syntax."
}

