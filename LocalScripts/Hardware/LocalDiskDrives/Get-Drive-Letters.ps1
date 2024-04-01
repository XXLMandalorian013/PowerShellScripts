$Drives = Get-PSDrive

$Drives | Where-Object {$_.Name -like '?'}
