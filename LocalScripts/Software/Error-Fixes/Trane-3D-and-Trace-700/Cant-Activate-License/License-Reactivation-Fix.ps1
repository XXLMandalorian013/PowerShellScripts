    #ReadMe
<#

Trace 3D and Load 300 activation fix.ps1


.DESCRIPTION
        
Fixes Trane/C.D.S.'s activation issue post their internal cyber sec update 2/6/2023,
causing Trane 3D or Trace Load 300 to request you to re-activate but never allowing you
to reactivate with their cloud licenses..  
    
    
.Notes

Tested working in 7.X.X.

.INPUTS
        
None.


.OUTPUTS
        
System.Strings, Verbosly stating the function steps it is doing.



.LINK

[about_Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.3)

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3)

[Write-Verbose](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-verbose?view=powershell-7.3)

[about_Try_Catch_Finally](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.3)

[Write-Error](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-error?view=powershell-7.3)

[Invoke-WebRequest](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.3)

[Expand-Archive](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.archive/expand-archive?view=powershell-7.3)

[Copy-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item?view=powershell-7.3)

[Start-Process](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process?view=powershell-7.3) 

#>

#Script

#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."   
}

#letting the user know what is starting.
function Start-ScriptBoilerplate {
    $ScriptName = "Trace 3D and Load 300 activation fix.ps1"

    $ScriptAuthor = "DAM"

    $ModifiedDate = "2023-03-06"

    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate"
    
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}


#Tells you if TRACE3DPlus is running.
function Get-TRACE3DPlusProcess {
    Try {
        Write-Verbose -Message "Get-TRACE3DPlusProcess" -Verbose
        $TRACE3D = Get-Process -ProcessName 'TRACE3DPlus' -ErrorAction STOP
        if ($TRACE3D){
            Throw "TRACE3D is running, remote into the users PC, save their work and close the program."
        }  
    }Catch{
        Write-Error -Message $_
    }
}

#Tells you if TRACE Load 300 is running.
function Get-TRACELoad700 {
    Try {
        Write-Verbose -Message "Get-TRACELoad700" -Verbose
        $TRACELoad700 = Get-Process -ProcessName 'TRACE' -ErrorAction STOP
        if ($TRACELoad700) {
            Throw "TRACELoad700 is running, remote into the users PC, save their work and close the program."
        }
    }Catch{
        Write-Error -Message $_
    }  
}

#Downloads the files from Trane/C.D.S's website. https://tranecds.custhelp.com/app/answers/detail/a_id/1002/kw/activation?mkt_tok=MzEzLUpYRC01ODUAAAGKRy3fVhEmLVHFLp_V16KwpMnvtkVvw6DY3L8BUff2s_ubErdDFhHmzigvx0sjPX1Rj7TgwJFwq1vdgmMmIKKaq-nDC4tBzoDPIqZjurk3YyiGew
function Get-FixDownload {
    #Downloads Program via web.

    Try {
        Write-Verbose -Message "Get-FixDownload" -Verbose
        $TempZipedPath = "C:\CDSActivationHotFix.zip"
        $OutFile = "$TempZipedPath"
        $URI = 'https://tranecds.custhelp.com/ci/fattach/get/418526/0/session/L2F2LzEvdGltZS8xNjc4MTA5NzYwL2dlbi8xNjc4MTA5NzYwL3NpZC9mVTNGNjlHczNzYTVXSEcxTWphWGNzTF9wMnZNaG5wTFE3RzYlN0UwS3lTRm1vSTQxR1g4T0pCZVpydUFiUyU3RXJxS3FGUnl4bFZPb2NrYTN2MklzaGNmYUcwak94VlZySzZ3WU1lMnZBS2RJVHhRZlEyM1lpemoySDlnJTIxJTIx/filename/CDSActivationHotFix.zip'
        Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing -ErrorAction STOP
    }Catch {
        Write-Error -Message $_
    }
}

#Unzips the files
function Export-ZippedFiles {
    #Downloads Program via web.

    Try {
        Write-Verbose -Message "Export-ZippedFiles" -Verbose
        $ZippedPath = "C:\CDSActivationHotFix.zip"
        $UnzipedPath = "C:\CDSActivationHotFix"
        Expand-Archive -LiteralPath "$ZippedPath" -DestinationPath "$UnzipedPath" -ErrorAction STOP
        Start-Sleep -Seconds 8
    }Catch {
        Write-Error -Message $_
    }
}

#Copies the hot fix files to Trace 700 folder.
function Add-FixFilesforTrace700 {
    Try {
        Write-Verbose -Message "Add-FixFilesforTrace700" -Verbose
        $File1 = "C:\CDSActivationHotFix\CDSAct.dll"
        $File2 = "C:\CDSActivationHotFix\FNOPublicServices.dll"
        Copy-Item -Path "$File1" -Destination "C:\Program Files (x86)\Trane\TRACE 700" -force -ErrorAction STOP
        Copy-Item -Path "$File2" -Destination "C:\Program Files (x86)\Trane\TRACE 700" -force -ErrorAction STOP
        Start-Sleep -Seconds 8
    }Catch {
        Write-Error -Message $_
    }
}

#Copies the hot fix files to Trace 3D folder.
function Add-FixFilesforTrace3D {
    #Downloads Program via web.

    Try {
        Write-Verbose -Message "Add-FixFilesforTrace3D" -Verbose
        $File1 = "C:\CDSActivationHotFix\CDSAct.dll"
        $File2 = "C:\CDSActivationHotFix\FNOPublicServices.dll"
        Copy-Item -Path "$File1" -Destination "C:\Program Files\Trane\TRACE 3D Plus" -force -ErrorAction STOP
        Copy-Item -Path "$File2" -Destination "C:\Program Files\Trane\TRACE 3D Plus" -force -ErrorAction STOP
        Start-Sleep -Seconds 8
    }Catch {
        Write-Error -Message $_
    }
}

#Runs Trace 700.
function Start-Trace700 {
    Try {
        Write-Verbose -Message "Start-Trace700" -Verbose
        Start-Process -FilePath "C:\Program Files (x86)\Trane\TRACE 700\Trace.exe" -Verb RunAs -ErrorAction STOP
    }Catch {
        Write-Error -Message $_
    }
}

#Runs Trace 3D
function Start-Trace3D {
    Try {
        Write-Verbose -Message "Start-Trace3D" -Verbose
        Start-Process -FilePath "C:\Program Files\Trane\TRACE 3D Plus\TRACE3DPlus.exe" -Verb RunAs -ErrorAction STOP
    }Catch {
        Write-Error -Message $_
    }
}

#States the script has stopped.
function Stop-Script {
    try {
        Write-Verbose -Message "The script has finished, now remote into the users PC and active the licneses for Trace 3D and 700." -Verbose
        Start-Sleep -Seconds 5
        Exit
    }catch {
        Write-Error -Message $_
    }
}

#letting the user know what is starting.
Start-ScriptBoilerplate

#Tells you if TRACE3DPlus is running.
Get-TRACE3DPlusProcess

#Tells you if TRACE Load 300 is running.
Get-TRACELoad700

#Downloads the files from Trane/C.D.S's website.
Get-FixDownload

#Unzips the files
Export-ZippedFiles

#Copies the hot fix files to Trace 700 folder.
Add-FixFilesforTrace700

#Copies the hot fix files to Trace 3D folder.
Add-FixFilesforTrace3D

#Runs Trace 700
Start-Trace700

#Runs Trace 3D
Start-Trace3D

#States the script has stopped.
Stop-Script