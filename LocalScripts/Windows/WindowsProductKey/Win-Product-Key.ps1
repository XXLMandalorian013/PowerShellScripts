#Grabs the product key if not baked into the mobo.
function Get-WindowsProductKey {
    param (
        [string]$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
    )
    $DigitalProductId = (Get-ItemProperty -Path $Path).DigitalProductId
    $KeyOffset = 52
    $Chars = "BCDFGHJKMPQRTVWXY2346789"
    $ProductKey = ""
    for ($i = 24; $i -ge 0; $i--) {
        $Current = 0
        for ($j = 14; $j -ge 0; $j--) {
            $Current = $Current * 256 + $DigitalProductId[$KeyOffset + $j]
            $DigitalProductId[$KeyOffset + $j] = [math]::Floor($Current / 24)
            $Current = $Current % 24
        }
        $ProductKey = $Chars[$Current] + $ProductKey
    }
    return $ProductKey.Insert(5, "-").Insert(11, "-").Insert(17, "-").Insert(23, "-")
}
Get-WindowsProductKey
