    #ReadMe
<#

Disk-Warning

.DESCRIPTION
        
Adds a file name extension to a supplied name.  
    
    
.Notes

Notes here.
    

.PARAMETER Name
        
Specifies the file name.

    
.PARAMETER Extension
        
Specifies the extension. "Txt" is the default.


.INPUTS

None.

.OUTPUTS

System.String. Disk warnings outputs over the span of a week.

.EXAMPLE

PS C:\Users\DAM> Get-EventLog -LogName "System" -Source "disk" -After $Begin -Before $End

Index Time          EntryType   Source                 InstanceID Message
----- ----          ---------   ------                 ---------- -------
281256 Jul 11 07:21  Warning     disk                   2147745945 The IO operation at logical blo…
280774 Jul 10 13:21  Warning     disk                   2147745843 An error was detected on device…

.LINK

[about_Eventlogs](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_eventlogs?view=powershell-5.1&viewFallbackFrom=powershell-7.2)

[Get-EventLog](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-eventlog?view=powershell-5.1&viewFallbackFrom=powershell-7.3)

[Get-Date](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.3S)

#>

#Region Start-Script

#Global Variables


#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    $ScriptName = "Disk-Warning.ps1"

    $ScriptAuthor = "DAM"

    $ModifiedDate = "2023-07-20"

    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate"
    
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}

#Grabs disk warnings over the span of a week.
function Get-DiskWarnings {
    $Today = Get-Date

    $Begin = $Date

    $End = $Today.AddDays(-7)

    Get-EventLog -LogName "System" -EntryType "Warning" -Source "disk" -After $Begin -Before $End | Format-List

    Write-Verbose -Message "The curent time and date is $Today" -Verbose

}

Start-ScriptBoilerplate

Get-DiskWarnings

#EndRegion

