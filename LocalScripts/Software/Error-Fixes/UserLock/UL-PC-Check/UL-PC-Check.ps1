    #ReadMe
<#

UL-PC-Check.ps1

.SYNOPSIS

Adds a file name extension to a supplied name.

.DESCRIPTION

Adds a file name extension to a supplied name.  

.Notes

#Be sure specify the domain name and the user account under the -Member peram in the Find-ULDomainAcct function.

If the impersiniation account is removed from the computer the Find-ULDomainAcct Get-CimInstance -Class win32_useraccount will display as if it is still on though its not. Check the GUI if this passes but you,
#still see "Access Denined" in the UL portal on the decice you are running this on.

.OUTPUTS

System.String. Add-Extension returns a string with the extension or file name.

.EXAMPLE

PS> extension "File" "doc"
File.doc

.LINK

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.4) 

[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.4)

[Everything you wanted to know about the if statement](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.4)

#>

#Region Start-Script

#Variables

#Company's ADDS domain name.
$DomainName = 'demaskholdings.ds'

#Name of the server hosting UL.
$ULHostedServer = 'DEMO-SVR-01'

#The is the domain account that was use to setup the UL server app, spoofing access to ADDS.
$DomainAdminAcct = 'vsadmin'

#Functions

#Script Boilerplate.
function Start-ScriptBoilerplate {
    param (
        $ScriptName = "UL-PC-Check.ps1",
        $ScriptAuthor = "DAM",
        $ModifiedDate = "2023-12-20",
        $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor, last modified on $ModifiedDate"
    )
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}

#Check to see if the PC is on a domain or Workgroup.
function Test-Domain {
    $OSInfo = Get-ComputerInfo | Select-Object 'CsDomain'
    if ($OSInfo -match $DomainName) {
        Write-Verbose -Message "$env:computername is apart of the $OSInfo's domain" -Verbose
    }else{
        Write-Verbose -Message "$env:computername is on a workgroup: $OSInfo" -Verbose
    }
    
}

#Checks if the Remote Registry is running on the machine.
function Test-RemoteRegistry {
    $RemoteRegistry = Get-Service -Name RemoteRegistry | Select-Object 'Status'
    if ($RemoteRegistry -match 'Running') {
        Write-Verbose -Message "Remote Registry is $RemoteRegistry" -Verbose
    }Else{
        Write-Verbose -Message "Remote Registry is $RemoteRegistry" -Verbose
    }
}

#Tests ICMP (Ping) to the UL server.
function Test-ConnectionToULServer {
    $TestConnection = Test-Connection -ComputerName "$ULHostedServer"
    if ($TestConnection -match $ULHostedServer) {
        Write-Verbose -Message "Testing connection to computer '$ULHostedServer' succeeded: Resolve the target '$ULHostedServer'." -Verbose
    }Else{
        Write-Verbose -Message "Testing connection to computer '$ULHostedServer' failed: Cannot resolve the target name." -Verbose
    }
}

#SMB 445 aka SMB2.0 status.
function Test-SMB2 {
    $SMB = Get-SmbServerConfiguration | Select-Object 'EnableSMB2Protocol'
    if ($SMB -match 'True') {
        Write-Verbose -Message "SMB 445 aka SMB2.0 is enabled." -Verbose
    }Else{
        Write-Verbose -Message "SMB 445 aka SMB2.0 is not enabled." -Verbose
    }
}


#Checks for the impersination domain admin account that UL is leveraging account is on the device. If not found it will add the account. 
#Note, if the impersiniation account is removed from the computer the Get-CimInstance -Class win32_useraccount will display as if it is still on though its not. Check the GUI if this passes but you,
#still see "Access Denined" in the UL portal on the decice you are running this on.
function Find-ULDomainAcct {
    $ULDomainAcct = Get-CimInstance -Class win32_useraccount | Where-Object {$_.Domain -ne $null -and $_.LocalAccount -eq $false -and $_.Name -eq "$DomainAdminAcct"} | Select-Object Name, Domain
    if ($ULDomainAcct -match $DomainAdminAcct) {
        Write-Verbose -Message "The domain admin acct '$DomainAdminAcct' is on $env:computername." -Verbose
    }else{
        Write-Verbose -Message "The domain admin acct '$DomainAdminAcct' is not on $env:computername. Adding '$DomainAdminAcct'." -Verbose
        try {
            #Be sure specify the domain name and the user account under the -Member peram
            Add-LocalGroupMember -Name "Administrators" -Member demaskholdings.ds\vsadmin
        }
        catch {
            $Error
        }
    }
}







#****Needs fixed********Needs fixed********Needs fixed********Needs fixed****
#Looks to see if the UL agent is installed.
#function Find-ULAgent {
    #param (
        #$Folder = "ISDecisions"
    #)
    #Get-ChildItem -Path C:\ -Directory -Recurse -Filter "$Folder" -ErrorAction SilentlyContinue | Select-Object -First 1 | ForEach-Object {
        #if ($_.Name -match $Folder) {
            #Write-Verbose -Message "Folder found: $($_.FullName)." -Verbose
        #}
        #else {
            #Write-Verbose -Message "The UL Agent is not installed." -Verbose
        #}
    #}
#}
#****Needs fixed********Needs fixed********Needs fixed********Needs fixed****

#Calling Functions

#Script Boilerplate.
Start-ScriptBoilerplate

#Check to see if the PC is on a domain or Workgroup.
Test-Domain

#Checks if the Remote Registry is Enabled and running on the machine.
Test-RemoteRegistry

#Tests ICMP (Ping) to the UL server.
Test-ConnectionToULServer

#SMB 445 aka SMB2.0 status.
Test-SMB2

#Checks for the impersination domain admin account that UL is leveraging account needs to be present on the device.
Find-ULDomainAcct 

#Looks to see if the UL agent is installed.
Find-ULAgent

#EndRegion



#****Apart of UL Anyware****#****Apart of UL Anyware****#****Apart of UL Anyware****
#$tcpClient = New-Object System.Net.Sockets.TcpClient
#$tcpClient.Connect("$env:computername", 80)
#$tcpClient.Connect("$env:computername", 443)
#$tcpClient.Close()
#****Apart of UL Anyware****#****Apart of UL Anyware****#****Apart of UL Anyware****











