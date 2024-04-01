    #ReadMe
<#


    .SYNOPSIS
    
      Gets info on a PS session.  

    .Notes

        Works in 5.1 and newer

    .Link

    [Get-PSSession OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-pssession?view=powershell-7.2)
    
    [about_PSSessions OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pssessions?view=powershell-7.2)
#>  


#Script

#Am I already connected to ExchangeOnline?

$PSSessionsName = Get-PSSession | Select-Object -Property "Name"

if ("$PSSessionsName" -match 'ExchangeOnlineInternalSession') 
{
    Throw "Your are already connected to $PSSessionsName"
}   
else
{
    Write-Host 'Starting connection to ExchangeOnlineInternalSession'
} 