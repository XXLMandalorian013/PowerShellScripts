#Created a folder temp folder for downloading.
    #https://docs.microsoft.com/en-us/powershell/scripting/samples/working-with-files-and-folders?view=powershell-7.2
        New-Item -Path 'C:\TEMP\' -ItemType Directory

#Downloads software from the web. Make sure to add the downloads .exe full name in the -outfile file path or you will get access denied.
    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.2
        Invoke-WebRequest https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_15128-20224.exe -OutFile C:\TEMP\officedeploymenttool_15128-20224.exe