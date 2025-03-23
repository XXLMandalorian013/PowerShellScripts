$BaseDirPath = "C:"
$DirName = "\Program Files (x86)\Sophos\Connect\import"
$FileName = "FST-SCONNECT.PRO"
#PS Array to add data/cmds to a file. Note the ' ' must be at the start and end of the code.
# Note the display name and gateway should be the same IP of the FW the VPN user are accessing. user_portal_port may need changed.
    $data = @(
            
               '
{  
"display_name": "XXX.XXX.XXX.XXX",  
"gateway": "XXX.XXX.XXX.XXX",
"user_portal_port": 4443,
"otp": false,
"auto_connect_host": "",
"can_save_credentials": false,
"check_remote_availability": false,
"run_logon_script": false
}
                '
            
    )
#Creates the file.
        try {
            if (Test-Path -Path "$BaseDirPath\$DirName\$FileName") {
                Write-Verbose -Message "$BaseDirPath\$DirName\$FileName already exsist...Moving to next step." -Verbose
            }else {
                cd C:\
                New-Item -Path "$BaseDirPath\$DirName" -Name "$FileName" -ItemType "File"
            }
        }
        catch {
            Get-Error -Newest 1
        }
        #adds the data
        start-sleep -seconds 3
        try {
            Add-Content -Path "$BaseDirPath\$DirName\$FileName" -Value $data
        }catch {
            Get-Error -Newest 1
        }
restart-service -name scvpn
Start-Sleep -Seconds 5