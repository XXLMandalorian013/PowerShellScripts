Write-host "Starting ipconfig /release"

ipconfig /release

Start-Sleep -Seconds 45

Write-host "ipconfig /flushdns"

ipconfig /flushdns

Start-Sleep -Seconds 45

Write-host "ipconfig /renew"

ipconfig /renew

Start-Sleep -Seconds 

Read-Host -Prompt "Press Enter to exit"