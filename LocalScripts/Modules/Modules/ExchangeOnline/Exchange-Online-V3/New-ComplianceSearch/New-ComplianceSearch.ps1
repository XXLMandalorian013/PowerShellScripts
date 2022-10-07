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
        
    https://learn.microsoft.com/en-us/powershell/module/exchange/get-managementrole?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/module/exchange/new-compliancesearch?view=exchange-ps


#>

#Script


New-ComplianceSearch -Name "TestSearch1" -ExchangeLocation "email@doamin.com" -ContentMatchQuery (c:c)(senderauthor="user@domain.com")

