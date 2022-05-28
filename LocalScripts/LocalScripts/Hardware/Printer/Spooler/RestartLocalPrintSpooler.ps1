Function Test-IsAdmin {
 
$user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) 
    }

    
If (!(Test-IsAdmin)) {
        Write-Warning "This script needs to run in a Admin PS Console"
        $HOST.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | OUT-NULL
        $HOST.UI.RawUI.Flushinputbuffer()
        Break
        }

#Stop, Clear and Start the Local Print Spooler

#Stop the local Print Spooler
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/stop-service?view=powershell-7.2
        Stop-Service -Name "spooler"

Start-Sleep -Seconds 1

#Delete the items in the spooler
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.2
        Remove-Item C:\Windows\System32\spool\PRINTERS\*

Start-Sleep -Seconds 1

#Start the local Print Spooler
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-service?view=powershell-7.2
        Start-Service -Name "spooler"
