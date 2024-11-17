$user = "stoulmin"  # Replace with the actual username
$isAdmin = (Get-LocalGroupMember -Group "Administrators" | Select-Object -ExpandProperty Name) -contains $user

if ($isAdmin) {
    Write-Output "$user has admin rights."
} else {
    Write-Output "$user does not have admin rights."
}