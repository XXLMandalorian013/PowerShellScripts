    #ReadMe

<#

    .SYNOPSIS
    
        #Tests the connection of a target

    .Notes

        #Works in 5.1 and Later

    .Link

    [Test-Connection Online](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-connection?view=powershell-7.2)

#>

#Script

#Test a website/web-host

Test-Connection -TargetName google.com


#Is Exchange down?

if (Test-Connection -TargetName outlook.office365.com -ErrorAction SilentlyContinue)
{
    Write-Host "outlook.office365.com is up!"
}else
{
    Throw "No Network connection or outlook.office365.com is down...see https://portal.office.com/adminportal/home?#/servicehealth"
}

