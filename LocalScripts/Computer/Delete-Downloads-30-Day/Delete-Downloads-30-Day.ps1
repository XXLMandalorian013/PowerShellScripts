# Specify the base path where user profiles are stored
$userProfilesPath = "C:\Users"

# Loop through each user profile
Get-ChildItem -Path $userProfilesPath -Directory | ForEach-Object {
    $userDownloadsPath = Join-Path -Path $_.FullName -ChildPath "Downloads"
    $cutoffDate = (Get-Date).AddDays(-30)

    # Delete files older than 30 days in the Downloads folder
    Get-ChildItem -Path $userDownloadsPath -File | Where-Object {
        $_.LastWriteTime -lt $cutoffDate
    } | Remove-Item -Force
}
