$groupId = '12345abcdefg';
if (!(Test-Path "C:\Temp")) {
    mkdir "C:\Temp";
}
if ([Environment]::Is64BitOperatingSystem) {
    $downloadURL = "https://api.threatlocker.com/installers/threatlockerstubx64.exe";
}
else {
    $downloadURL = "https://api.threatlocker.com/installers/threatlockerstubx86.exe";
}
$localInstaller = "C:\Temp\ThreatLockerStub.exe";
Invoke-WebRequest -Uri $downloadURL -OutFile $localInstaller;
& C:\Temp\ThreatLockerStub.exe InstallKey=$groupId;