#Uninstall Quick Assist win 10

$checkQuickAssist = Get-WindowsCapability -online | where-object {$_.name -like "*QuickAssist*"}

if ($checkQuickAssist.state -eq 'Installed') {

    try {

        Remove-WindowsCapability -online -name $checkQuickAssist.name -ErrorAction Stop

    } catch {

        $error[0].Exception.Message

    }

}