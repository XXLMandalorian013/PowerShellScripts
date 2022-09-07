 
#        .SYNOPSIS
        Adds a file name extension to a supplied name.

#        .DESCRIPTION
        Adds a file name extension to a supplied name.
        Takes any strings for the file name or extension.

#        .PARAMETER Name
        Specifies the file name.

#        .PARAMETER Extension
        Specifies the extension. "Txt" is the default.

#        .INPUTS
        None. You cannot pipe objects to Add-Extension.

#        .OUTPUTS
        System.String. Add-Extension returns a string with the extension or file name.

#        .EXAMPLE
        PS> extension -name "File"
        File.txt

#        .EXAMPLE
        PS> extension -name "File" -extension "doc"
        File.doc

# RELATED LINKS
[https://docs.microsoft.com/powershell/module/microsoft.powershell.management/checkpoint-computer?view=powershell-5.1&WT.mc_id=ps-gethelp](URL "Online Version:")
    