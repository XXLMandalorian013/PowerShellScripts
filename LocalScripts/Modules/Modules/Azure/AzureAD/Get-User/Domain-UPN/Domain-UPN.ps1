    #ReadMe
<#
    
    .SYNOPSIS

        Domain User Principal Name.


    .DESCRIPTION

        Grabs all emails with the specified domain.


    .OUTPUTS
        
        UserPrincipalName
        -----------------
        JMDoe@domain.com
        BMFartz@domain.com





    .LINK
        
        https://docs.microsoft.com/en-us/powershell/module/azuread/get-azureaduser?view=azureadps-2.0

        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.2

#>

#Script

$AllUsers = Get-AzureADUser | Select-Object UserPrincipalName

$AllUsers -match 'domainhere.com' #Change to your Org

