    #ReadMe
<#

Title
    
.SYNOPSIS

Adds a file name extension to a supplied name.


.DESCRIPTION
        
Adds a file name extension to a supplied name.  
    
    
.Notes

Notes here.
    

.PARAMETER Name
        
Specifies the file name.

    
.PARAMETER Extension
        
Specifies the extension. "Txt" is the default.


.INPUTS
        
None. You cannot pipe objects to Add-Extension.


.OUTPUTS
        
System.String. Add-Extension returns a string with the extension or file name.


.EXAMPLE
        
PS> extension "File" "doc"
File.doc


.LINK
        
[WinGet Install Online Version](https://learn.microsoft.com/en-us/windows/package-manager/winget/install) 

#>

#Region Start-Script

#Global Variables

$Global:VMFolder = 'I:\HyperV\VMs'

$Global:VMName = 'Win10VM-Test-2'

#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    $ScriptName = "New-VM.ps1"

    $ScriptAuthor = "DAM"

    $ModifiedDate = "2023-05-10"

    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate"
    
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}

function New-VM {

    $NewVMArguments = @{
        Name = "$Global:VMName"
        MemoryStartupBytes = '8GB'
        BootDevice = 'VHD'
        NewVHDPath = "$Global:VMFolder\$Global:VMName"
        Path = "$Global:VMFolder\$Global:VMName"
        NewVHDSizeBytes = '120GB'
        Generation = '2'
        Switch = 'New Virtual Switch'

    }

    try {
        $TestExsistingPath = Test-Path -Path "$Global:VMFolder\$Global:VMName"

        if ($TestExsistingPath -match 'False') {

        New-Item -Path $Global:VMFolder -Name $Global:VMName -ItemType "Directory" -ErrorAction Stop

        }else {
            Throw "The VM folder already exists."
        }
    }
    catch {
        Throw "$Error"
    }

    try {
        New-VM $NewVMArguments -ErrorAction Stop
    }
    catch {
        Throw "$Error"
    }
}


#Letting the user know what is starting.
Start-ScriptBoilerplate

#Creates a new VM.
New-VM

#EndRegion