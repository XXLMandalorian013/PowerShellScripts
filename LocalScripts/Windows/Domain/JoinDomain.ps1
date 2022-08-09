#Checks the PS Terminal to be ran at a specific version and elevation
        #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_requires?view=powershell-7.2
                #Requires -Version 5.1
                #Requires -RunAsAdministrator

#Joins a PC to the domain via credentials
        #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-computer?view=powershell-5.1
                $DomainName = Read-Host -Prompt "Enter Domain Name You Wish To Join"     
        
                Add-Computer -DomainName $DomainName


