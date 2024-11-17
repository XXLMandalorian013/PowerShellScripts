#ReadMe

<#

Datto-RMM-Uninstall.ps1

.SYNOPSIS

Uninstalls Datto RMM via.

.Notes

An elivated terminal and PS Ver 3.0 or higher is required.

#>

#Script

#Region Start-Script

#Letting the user know what is starting.

function Start-ScriptBoilerplate {

    param (

        $ScriptName = "Datto-RMM-Uninstall.ps1",

        $ScriptAuthor = "DAM",

        $WrittenDate = "2024-06-18",

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

        Exit

    }else {

        Write-Verbose -Message "The terminal is running as an Administrator...Continuing script..." -Verbose

    }

}

#Checks to see if the software is already installed, if not, it installs it.

function Uninstall-Software {

    param (

        #Program Path when its installed.

        $ProgramPath1 = "C:\Program Files (x86)\CentraStage\uninst.exe",

        #Program Path when its installed.

        $ProgramPath2 = "C:\Program Files\CentraStage\uninst.exe",

        #Out-File location.

        $OutFile = "C:\$InstallerName"

    )

    #Checks to see if the RMM is install at C:\Program Files (x86)\CentraStage\uninst.exe.

    $TestPath = Test-Path -Path "$ProgramPath1"

    if ($TestPath -match 'False') {

        Write-Verbose -Message "$ProgramPath1 is already uninstalled..." -Verbose

    }else {

        #Uninstalls Datto RMM.

        try {

            Write-Verbose -Message "Uninstalling $ProgramPath1" -Verbose

            Start-Process -FilePath "$ProgramPath1" -ArgumentList "/s"

            Start-Sleep -Seconds 10

            #Install check.

            try {

                do { 

                    $TestPath = Test-Path -Path "$ProgramPath1"

                    if ($TestPath -match 'True') {

                        Write-Verbose -Message "$ProgramPath1 installer is running...Please wait" -Verbose

                        Start-Sleep -Seconds 8

                    }

                } 

                Until ($TestPath -match 'False')

                Start-Sleep -Seconds 8

                Write-Verbose -Message "$ProgramPath1 Uninstalled!" -Verbose

            }catch {

                Write-Verbose -Message "Error[0]" -Verbose

            }

        }catch {

            Write-Verbose -Message "Error[0]" -Verbose

        }

        

    }

    #Checks to see if the RMM is install at C:\Program Files\CentraStage\uninst.exe.

    $TestPath = Test-Path -Path "$ProgramPath2"

    if ($TestPath -match 'False') {

        Write-Verbose -Message "$ProgramPath2 is already uninstalled..." -Verbose

    }else {

        #Uninstalls Datto RMM.

        try {

            Write-Verbose -Message "Uninstalling $ProgramPath1" -Verbose

            Start-Process -FilePath "$ProgramPath2" -ArgumentList "/s"

            Start-Sleep -Seconds 10

            #Install check.

            try {

                do { 

                    $TestPath = Test-Path -Path "$ProgramPath2"

                    if ($TestPath -match 'True') {

                        Write-Verbose -Message "$ProgramPath2 installer is running...Please wait" -Verbose

                        Start-Sleep -Seconds 8

                    }

                } 

                Until ($TestPath -match 'False')

                Start-Sleep -Seconds 8

                Write-Verbose -Message "$ProgramPath2 Uninstalled!" -Verbose

            }catch {

                Write-Verbose -Message "Error[0]" -Verbose

            }

        }catch {

            Write-Verbose -Message "Error[0]" -Verbose

        }

    }

}

    #Letting the user know what is starting.

    Start-ScriptBoilerplate

    #Checks to see if the terminal is running as an administrator.

    Test-TerminalElevation

    #Checks to see if the software is already installed, if not, it installs it.

    Uninstall-Software

#EndRegion