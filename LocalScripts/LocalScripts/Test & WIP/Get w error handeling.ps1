#Get w/ error handeling

$UserName = $env:UserName

Get-Process -Name Agent | Out-File -Path C:\LOCAL\$UserName\Desktop\$UserName'CDriveFullOutput'.txt -NoClobber -ErrorVariable ProcessError;
$ProcessError;

if ($ProcessError) {
    Get-Process -Name Agent | Out-File -Path C:\LOCAL\$UserName\Desktop\$UserName'2CDriveFullOutput'.txt -NoClobber
}