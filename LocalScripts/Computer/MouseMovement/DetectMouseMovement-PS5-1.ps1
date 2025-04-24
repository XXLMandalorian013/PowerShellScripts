#Windows PowerShell 5.1 Only
#Detects to see if the mouse is moving on a PC.

#https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms?view=windowsdesktop-6.0

#https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.cursors?view=windowsdesktop-6.0

#https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.cursor?view=windowsdesktop-6.0

#https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.control.cursor?view=windowsdesktop-6.0

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class MouseTracker {
    [DllImport("user32.dll")]
    public static extern bool GetCursorPos(out POINT lpPoint);
    public struct POINT { public int X; public int Y; }
}
"@ -Language CSharp

$p1 = New-Object MouseTracker+POINT
[MouseTracker]::GetCursorPos([ref]$p1)
Start-Sleep -Seconds 5
$p2 = New-Object MouseTracker+POINT
[MouseTracker]::GetCursorPos([ref]$p2)

if ($p1.X -eq $p2.X -and $p1.Y -eq $p2.Y) {
    Write-Host "The mouse did not move"
} else {
    Write-Host "The mouse moved"
}
