$SMB1 = Get-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol"  |Select-Object FeatureName, State, RestartRequired

$SMB1 | Format-List

Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol"