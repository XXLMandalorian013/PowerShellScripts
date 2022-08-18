#Grabs a list of all distro list. In the MAC I have added Distribution-List as the description of all of our distro lists. Make sure to add that descript for every new distro list made.
    
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-object?view=powershell-7.2
    
    #https://docs.microsoft.com/en-us/powershell/module/azuread/get-azureadgroup?view=azureadps-2.0
    
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.2

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
        
            Online version: http://www.fabrikam.com/extension.html

#>




    
        $ADGroupsDescription = Get-AzureADGroup | Select-Object DisplayName, Description

        $ADGroupsDescription -match 'Distribution-List'
