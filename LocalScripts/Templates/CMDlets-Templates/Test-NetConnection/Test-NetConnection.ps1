    #ReadMe
<#


    .SYNOPSIS
    
     Diag info on a connection  

    .Notes

        Works in 5.1 and newer

    .Link

    [Test-NetConnection OnlineVersion](https://learn.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection?view=windowsserver2022-ps)
   
#>  


#Script


#

#Can I dial out?/do I have a network connection

$NetworkConnection = Test-NetConnection | Select-Object 'PingSucceeded'

if ($NetworkConnection -match 'True')
{
    Write-Host "Network connection confirmed!"
}
else
{
    Throw "Check network connection"
}