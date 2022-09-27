    #ReadMe
<#
    
Restart-Computer

 .Notes

        Works in 5.1 or later and does not need elevated perm.

[Online Version](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/restart-computer?view=powershell-7.2)

#>

#Script

# Force even if programs are open and restarts the PC imediatly

Restart-Computer -Force


# Confirms its ok to restart w/ a promt.

Restart-Computer -Confirm

