
#Measure the dir created above and when triggered creates a BurntToast Notification as well as leaves open a PS 7.X Terminal stating some one has a full C:\.
#Be sure to change the Get-ChildItem, BurntToast notification, as well as the write host file locations.

        
$value = Get-ChildItem -path "\\Server\Folder" -recurse | Select-Object Length

if ($value.length -gt 0  )
{
    #Must install Nuget and BurntToast first use the  Install-Module -Name BurntToast in PS w/ admind to get both

New-BurntToastNotification -Text "C:\ Drive IS FULL!!!", "Check \\Server\Folder as someones C:\ Drive is Full!!! " -AppLogo C:\PS\'friendly neighborhood.png'

Write-Host "Checks to see if anyone has outputed a file in '\\Server\Folder' saying their C is = or >20GB"

Read-Host -Prompt "Press Enter to exit"
}