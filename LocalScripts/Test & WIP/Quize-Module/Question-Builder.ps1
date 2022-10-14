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


[Parameter(Mandatory,HelpMessage='Enter a Quiz Header Name')]
[string]$QuizHeader,

[Parameter(Mandatory,HelpMessage='Type the Question.')]
[string]$Question,

[Parameter(Mandatory,HelpMessage='Type answer 1.')]
[string]$Answer1,

[Parameter(Mandatory,HelpMessage='Type answer 2.')]
[string]$Answer2,

[Parameter(Mandatory,HelpMessage='Type answer 3.')]
[string]$Answer3,

[Parameter(Mandatory,HelpMessage='Type answer 4.')]
[string]$Answer4,

[Parameter(Mandatory,HelpMessage='Type answer 5.')]
[string]$Answer5,

[Parameter(Mandatory,HelpMessage='Type answer 6.')]
[string]$Answer6

 
$QuizHeader = Read-Host "Type a Quiz Header Name"
$Question = Read-Host "Type the Question"
$Answer1 = Read-Host "Type answer 1."
$Answer2 = Read-Host "Type answer 2."
$Answer3 = Read-Host "Type answer 3."
$Answer4 = Read-Host "Type answer 4."
$Answer5 = Read-Host "Type answer 5."
$Answer6 = Read-Host "Type answer 6."

