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
        
    CMDLet Online version: http://www.fabrikam.com/extension.html

#>

#Script


$QuizHeader = (Read-Host "Enter a Quiz Header Name.")

$Question = (Read-Host "Type the Question.")

$Answer1 = (Read-Host "Type answer 1.")

$Answer2 = (Read-Host "Type answer 2.")

$Answer3 = (Read-Host "Type answer 3.")

$Answer4 = (Read-Host "Type answer 4.")

$Answer5 = (Read-Host "Type answer 5.")

$Answer6 = (Read-Host "Type answer 6.")

$Answer = (Read-Host "Type correct answer.")

$QuizOutLocation = (Read-Host "Type a Dir to save this Quiz to.")

$OutFileName = (Read-Host "Type a Name for the .ps1")

$QuestionTemplate = @("$QuizHeader",'Oranges','Bananas')

$QuestionTemplate | Out-File -NoClobber -FilePath (Join-Path -Path "$QuizOutLocation" -ChildPath "$OutFileName.ps1")








