    #ReadMe
<#

Get-Specific-Running-Task

.DESCRIPTION
        
Tells you if a task is running or not baced unpon imput.
    
    
.Notes

Notes here.


.OUTPUTS
        
System.String,

TaskName is running or TaskName is not running


.LINK
        
[Get-ScheduledTask](https://learn.microsoft.com/en-us/powershell/module/scheduledtasks/get-scheduledtask?view=windowsserver2022-ps) 

#>

#Script

#letting the user know what is starting.

#Script Boilderplate
function Start-ScriptBoilerplate {
    $ScriptName = "Get-Specific-Running-Task.ps1"

    $ScriptAuthor = "DAM"

    $ModifiedDate = "2023-03-02"

    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate"
    
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}

Start-ScriptBoilerplate


function Get-RunningTask {

    [CmdletBinding()]
    param (
    [Parameter(Mandatory,HelpMessage='Type the programs name ie Automated-Restore-Point')]
    [string]$TaskName)

    Try {

        if (Get-ScheduledTask -TaskName "$TaskName" | Where-Object State -eq "Running") {
        Write-Host "$TaskName is running"
        }else {
        Write-Host "$TaskName is not running"
        }
    }Catch{
    Write-Error -Message $_
    }  
}

Get-RunningTask