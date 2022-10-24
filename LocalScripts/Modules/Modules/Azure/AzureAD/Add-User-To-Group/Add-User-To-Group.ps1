    #ReadMe
<#
    
    .SYNOPSIS

        Adds a file name extension to a supplied name.


    .DESCRIPTION
        Adds a file name extension to a supplied name.
        Takes any strings for the file name or extension.
    

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
        
        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-object?view=powershell-7.2
    
        https://docs.microsoft.com/en-us/powershell/module/azuread/get-azureadgroup?view=azureadps-2.0
    
        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.2

        https://docs.microsoft.com/en-us/powershell/module/azuread/add-azureadgroupmember?view=azureadps-2.0

        https://docs.microsoft.com/en-us/powershell/module/azuread/get-azureaduser?view=azureadps-2.0

#>

#Script

$UserIDGrab = Read-Host "Type Users Display Name"

Get-AzureADUser -Filter "userPrincipalName eq '$UserIDGrab'" | Select-Object 'ObjectId', 'DisplayName'

$DistList = Read-Host "Please Enter a Distribution List"

$ObjectID = Read-Host "Please enter a ObjectID"

Add-AzureADGroupMember -ObjectId "$DistList" -RefObjectId "$ObjectID"


