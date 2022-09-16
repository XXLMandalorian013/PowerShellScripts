    #ReadMe
<#
    .DESCRIPTION
        
        Removes a Reg key.  
    
    
    .Notes

        5.1 and newer.
    

    .OUTPUTS
        
        None


    .EXAMPLE
        
        PS> extension "File" "doc"
        File.doc


    .LINK
        
        Online version: https://docs.microsoft.com/en-us/powershell/scripting/samples/working-with-registry-keys?view=powershell-7.2

        Online version: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.2

#>

#Script

#Make sure to keep the Registry:: before the actual Reg key.

Remove-Item -Path 'Registry::HKEY_CURRENT_USER\TestKey' –Force