#Locks the PC if no mouse movment is detected.

    #https://docs.microsoft.com/en-us/powershell/scripting/samples/changing-computer-state?view=powershell-7.2

        Add-Type -AssemblyName System.Windows.Forms

        $SleepTime = 60

        $p1 = [System.Windows.Forms.Cursor]::Position

        Start-Sleep -Seconds $SleepTime  # The wait time from mouse P1 leading to P2.

        $p2 = [System.Windows.Forms.Cursor]::Position

        if($p1.X -eq $p2.X -and $p1.Y -eq $p2.Y) {
    
            Write-Host "The mouse did not move...Locking the PC"
    
            rundll32.exe user32.dll,LockWorkStation

        } else {
    
            Write-Host "PC is Active"

        }