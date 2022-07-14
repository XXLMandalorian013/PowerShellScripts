function Format-ByteSize {
    # helper function to format a given size in bytes
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateRange(0, [double]::MaxValue)]
        [double]$SizeInBytes
    )

    $units = "Bytes", "KB", "MB", "GB", "TB", "PB"
    $index = 0

    while ($SizeInBytes -gt 1024 -and $index -le $units.length) {
        $SizeInBytes /= 1024
        $index++
    }
    if ($index) { '{0:N2} {1}' -f $SizeInBytes, $units[$index] }
    else { "$SizeInBytes Bytes" }
}


$PCName = $env:computername
$UserName = $env:UserName

$FreeSpace = (Get-PSDrive -Name 'C').Free

if ($FreeSpace -le (20 * 1GB)) {

$Desktop = (Get-Childitem C:\LOCAL\$UserName\Desktop -File -Force -Recurse | Measure-Object -Sum Length).Sum

$Documents = (Get-ChildItem -Path C:\LOCAL\$UserName\'My Documents' -File -Force -Recurse | Measure-Object -Sum Length).Sum

$Downloads = (Get-Childitem C:\Users\$UserName\Downloads -File -Force -Recurse | Measure-Object -Sum Length).Sum

$Pictures = (Get-Childitem C:\LOCAL\$UserName\'My Documents'\'My Pictures' -File -Force -Recurse | Measure-Object -Sum Length).Sum

$Music = (Get-Childitem C:\LOCAL\$UserName\'My Documents'\'My Music' -File -Force -Recurse | Measure-Object -Sum Length).Sum

$Videos = (Get-Childitem C:\LOCAL\$UserName\'My Documents'\'My Videos' -File -Force -Recurse | Measure-Object -Sum Length).Sum

$RecycleBin = (Get-ChildItem -LiteralPath 'C:\$Recycle.Bin' -File -Force -Recurse -ErrorAction SilentlyContinue | Measure-Object -Sum Length).Sum


$Aray = [PsCustomObject]@{
    
    FreeSpace = Format-ByteSize $FreeSpace
    Desktop = Format-ByteSize $Desktop
    Documents = Format-ByteSize $Documents
    Downloads = Format-ByteSize $Downloads
    Pictures = Format-ByteSize $Pictures
    Music = Format-ByteSize $Music
    Videos = Format-ByteSize $Videos
    RecycleBin = Format-ByteSize $RecycleBin
}

$Aray | Export-Csv -Path (Join-Path -Path "\\HAWA-COL04\Support_Tools\Scripts\PS\Local Scripts\FullC\ScriptOutput" -ChildPath $UserName-$PCName'-FullCDrive'.csv)


}

#Thanks to Lee_Dailey and Theo for Dev help!