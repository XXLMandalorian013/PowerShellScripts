Write-Verbose -Message "Outputting the last 5 events on power events" -Verbose
# Define the event IDs related to power events
$powerEventIDs = @(5354)
# Query the System log for these event IDs and get the last 5 events
Get-WinEvent -LogName System | Where-Object { $powerEventIDs -contains $_.Id } | Select-Object -Last 5 | Format-List
Write-Verbose -Message "Outputting the last 5 events on PSU Issues" -Verbose
# Define the keyword to search for
$keyword = "PSU"
# Query the System log for events containing the keyword
Get-WinEvent -LogName System | Where-Object { $_.Message -like "*$keyword*" } | Select-Object -Last 5 | Format-List