$value = Get-ChildItem -path "\\ServerName\Folder\FullC\ScriptOutput" -recurse | Select-Object Length

if ($value.length -gt 0  )
{
    #Must install Nuget and BurntToast first use the  Install-Module -Name BurntToast in PS w/ admind to get both

New-BurntToastNotification -Text "C:\ Drive IS FULL!!!", "Check \\HAWA-COL04 as someones C:\ Drive is Full!!! " -AppLogo C:\PS\'friendly neighborhood.png'

Write-Host "Checks to see if anyone has outputed a file in "\\ServerName\Folder\FullC\ScriptOutput" saying their C is = or >20GB "

Read-Host -Prompt "Press Enter to exit"
}

