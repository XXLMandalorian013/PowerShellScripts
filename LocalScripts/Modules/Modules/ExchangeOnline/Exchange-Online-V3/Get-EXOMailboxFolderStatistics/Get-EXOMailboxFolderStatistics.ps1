    #ReadMe
<#
    
    .SYNOPSIS

        Adds a file name extension to a supplied name.


    .DESCRIPTION
        
        Adds a file name extension to a supplied name.  
    
    
    .Notes

        Notes here.
    

    .PARAMETER Name
        
        Specifies the file name.

    
    .PARAMETER Extension
        
        Specifies the extension. "Txt" is the default.


    .INPUTS
        
        None. You cannot pipe objects to Add-Extension.


    .OUTPUTS
        
        System.String. Add-Extension returns a string with the extension or file name.


    .EXAMPLE
        
        PS> extension "File" "doc"
        File.doc


    .LINK
        
        https://learn.microsoft.com/en-us/powershell/module/exchange/get-exomailboxfolderstatistics?view=exchange-ps

#>

#Script


param (
    [Parameter(Mandatory,HelpMessage='Type the email you wish to check')]
    [string]$Identity)

    $ParamArray = @(
    
  "Name"
  "CreationTime"
  "LastModifiedTime"
  "FolderPath"
  "FolderType"
  "VisibleItemsInFolder"
  "FolderSize"
  "ItemsInFolderAndSubfolders"
  "FolderAndSubfolderSize"
  
)


#Exchange Online module 2.0.5 (V2) and newer requires PS 7.X.X.


if ($PSVersionTable.PSVersion.Major -eq 7) {
		
	Write-Host "This script is running in $($PSVersionTable.PSVersion)."
	
} 

else {
	
    Write-Warning "This script is running in PowerShell $($PSVersionTable.PSVersion)...Please run this script in PowerShell  Version 7.X.X...Ending Script" -WarningAction Inquire
		
	Start-Sleep -Seconds 3

	Exit
}

Get-EXOMailboxFolderStatistics -Identity $Identity | Select-Object $ParamArray


