#https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/chkdsk
    #Checks File System Data and Meta Data of a Volume for Logical and Physical Errors
CHKDSK C:



#Get Logged Username and PC to exported CSV Naming
$UserName = $env:UserName
$PCName = $env:computername

#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/get-winevent?view=powershell-7.2#syntax
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-csv?view=powershell-7.2
            #Accesses the Event Log for CHKDSK Log
$CSV = Get-WinEvent -FilterHashtable @{LogName = "Application"; ID = "26212"} 
$CSV | Export-Csv -Path (Join-Path -Path "\\ServerName\Folder\CHKDSK\ScriptOutput" -ChildPath $PCName-$UserName'-CHKDSK'.csv)

