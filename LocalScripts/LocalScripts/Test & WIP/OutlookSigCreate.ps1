$Outlook = "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"

#https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2
if(Get-Item -Path $Outlook -ErrorAction Ignore)
{

Write-Host "Outlook is installed."

}
else
{
Write-Host "Outlook is not installed."

}

$User = $env:UserName

$SigFolderPath = "C:\Users\$User\AppData\Roaming\Microsoft\Signatures"

#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-item?view=powershell-7.2
if(Get-Item -Path $SigFolderPath -ErrorAction Ignore)
{

Write-Host "Folder Exists"

}
else
{
Write-Host "Created Folder"

#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.2
#Creates the Signatures Folder for Outlook
New-Item -Path C:\Users\$User\AppData\Roaming\Microsoft -Name "Signatures" -ItemType "Folder"
}

$SigFolderTemplate = "\\ServerName\Folder\OutlookSigCreate\SignaturesTemplate-4-5-22"

#https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2
if(Get-Item -Path $SigFolderTemplate -ErrorAction Ignore)
{

Write-Host "Signatures Exists"

}
else
{
Write-Host "Signatures Imported"

#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item?view=powershell-7.2
#Copys the Signature Template to Outlook
Copy-Item -Path "$SigFolderTemplate" -Destination "C:\Users\$User\AppData\Roaming\Microsoft\Signatures" -Recurse
}

        