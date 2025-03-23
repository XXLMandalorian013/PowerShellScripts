Write-Verbose -Message "Getting the last 5 Power Events...please wait" -verbose
# Define the event IDs to filter
$eventIDs = @(41, 1074, 6006, 6008)
# Get the last 10 events for the specified event IDs
Get-EventLog -LogName System | Where-Object { $eventIDs -contains $_.EventID } | Select-Object -Property TimeGenerated, EntryType, Source, EventID, Message -Last 5