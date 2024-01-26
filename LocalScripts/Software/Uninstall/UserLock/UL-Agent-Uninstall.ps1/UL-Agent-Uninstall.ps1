
$SoftwareName = UlAgentService

taskkill /f /im "$SoftwareName"

Set-Location -Path 'C:\Windows\SysWOW64'

Start-Process -FilePath 'C:\Windows\SysWOW64\ULAgentExe.exe /SERVICE U'

Start-Process -FilePath 'C:\Windows\SysWOW64\ULAgentExe.exe /UNREGISTER'