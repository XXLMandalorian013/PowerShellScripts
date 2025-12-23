#To be ran when the following error happen when enabling BL. Add-TpmProtectorInternal : The system cannot find the file specified. (Exception from HRESULT: 0x80070002)
Rename-Item -Path C:\Windows\System32\Recovery\ReAgent.xml -NewName ReAgent.old
