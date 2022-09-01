 
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

#        .LINK
        https://knowledge.autodesk.com/support/revit/troubleshooting/caas/CloudHelp/cloudhelp/2021/ENU/Revit-Troubleshooting/files/GUID-3562A7E7-7112-4B6D-97F6-D922BACC0CDF-htm.html
    