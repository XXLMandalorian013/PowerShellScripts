    #ReadMe
<#
    
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
        
    https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.2

#>

#Script

    
Write-Host “================ $QuizHeader ================”
    
Write-Host "$Question"

Write-Host “$Answer1”
Write-Host “$Answer2”
Write-Host “$Answer3”
Write-Host “$Answer4”
Write-Host “$Answer5”
Write-Host “$Answer6”



