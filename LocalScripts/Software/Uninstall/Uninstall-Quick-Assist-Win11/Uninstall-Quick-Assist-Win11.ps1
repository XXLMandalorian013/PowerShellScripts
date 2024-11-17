#Uninstall Quick Assist Win 11
$AppXPackage = Get-AppXPackage -Name "*QuickAssist"
$AppXPackageName = $AppXPackage.Name
Remove-AppxPackage -Package $AppXPackageName