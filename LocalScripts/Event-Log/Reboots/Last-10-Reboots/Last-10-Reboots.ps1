# Define the event IDs related to system reboots
$eventIDs = @(41, 1074, 6006, 6008)
# Get the last 10 events matching the specified event IDs
Get-EventLog -LogName System | Where-Object { $eventIDs -contains $_.EventID } | 
Select-Object -First 10 TimeGenerated, EntryType, Source, EventID, Message
