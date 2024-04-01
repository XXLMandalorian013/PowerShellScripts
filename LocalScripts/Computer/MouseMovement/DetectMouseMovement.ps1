#Detects to see if the mouse is moving on a PC.

#https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms?view=windowsdesktop-6.0

#https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.cursors?view=windowsdesktop-6.0

#https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.cursor?view=windowsdesktop-6.0

#https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.control.cursor?view=windowsdesktop-6.0

Add-Type -AssemblyName System.Windows.Forms

$p1 = [System.Windows.Forms.Cursor]::Position
Start-Sleep -Seconds 5  # or use a shorter intervall with the -milliseconds parameter
$p2 = [System.Windows.Forms.Cursor]::Position
if($p1.X -eq $p2.X -and $p1.Y -eq $p2.Y) {
    Write-Host "The mouse did not move"
} else {
    Write-Host "The mouse moved"
}