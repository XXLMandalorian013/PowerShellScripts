### Note, run this CMD unelevated or it will not show up in FileExplor. If it is ran elevated, it will need to be removed.
### Checks for a specific drive letter. If found, it deletes the old letter, maps the new one and stops/starts File Explorer.
function Redo-DriveMapping {
    param (
        $DriveLetterCheck1 = "M",
        $DriveLetterCheck2 = "P",
        $DriveLetterCheck3 = "Z",
        $DriveLetterCheck4 = "L",
        $DriveLetterCheck5 = "I",
        $DriveLetterCheck6 = "F",
        $DriveLetterCheck7 = "X",
        $DriveLetterCheck8 = "K"
    )
    $PSDriveName1 = Get-PSDrive | Where-Object Name -EQ "M"
    if ($PSDriveName1.Name -match "$DriveLetterCheck1") {
        Write-Verbose -Message "$DriveLetterCheck1 Drive found...remapping drive..." -Verbose
        net use M: /delete
        Start-Sleep -Seconds 8
        net use M: "\\Server\Folder" /persistent:yes
    }
    $PSDriveName2 = Get-PSDrive | Where-Object Name -EQ "P"
    if ($PSDriveName2.Name -match "$DriveLetterCheck2") {
        Write-Verbose -Message "$DriveLetterCheck2 Drive found...remapping drive..." -Verbose
        net use P: /delete
        Start-Sleep -Seconds 8
        net use P: "\\Server\Folder" /persistent:yes
    }
    $PSDriveName3 = Get-PSDrive | Where-Object Name -EQ "Z"
    if ($PSDriveName3.Name -match "$DriveLetterCheck3") {
        Write-Verbose -Message "$DriveLetterCheck3 Drive found...remapping drive..." -Verbose
        net use Z: /delete
        Start-Sleep -Seconds 8
        net use Z: "\\Server\Folder" /persistent:yes
    }
    $PSDriveName4 = Get-PSDrive | Where-Object Name -EQ "L"
    if ($PSDriveName4.Name -match "$DriveLetterCheck4") {
        Write-Verbose -Message "$DriveLetterCheck4 Drive found...remapping drive..." -Verbose
        net use L: /delete
        Start-Sleep -Seconds 8
        net use L: "\\Server\Folder" /persistent:yes
    }
    $PSDriveName5 = Get-PSDrive | Where-Object Name -EQ "I"
    if ($PSDriveName5.Name -match "$DriveLetterCheck5") {
        Write-Verbose -Message "$DriveLetterCheck5 Drive found...remapping drive..." -Verbose
        net use I: /delete
        Start-Sleep -Seconds 8
        net use I: "\\Server\Folder" /persistent:yes
    }
    $PSDriveName6 = Get-PSDrive | Where-Object Name -EQ "F"
    if ($PSDriveName6.Name -match "$DriveLetterCheck6") {
        Write-Verbose -Message "$DriveLetterCheck6 Drive found...remapping drive..." -Verbose
        net use F: /delete
        Start-Sleep -Seconds 8
        net use F: "\\Server\Folder" /persistent:yes
    }
    $PSDriveName7 = Get-PSDrive | Where-Object Name -EQ "X"
    if ($PSDriveName7.Name -match "$DriveLetterCheck7") {
        Write-Verbose -Message "$DriveLetterCheck7 Drive found...remapping drive..." -Verbose
        net use X: /delete
        Start-Sleep -Seconds 8
        net use X: "\\Server\Folder" /persistent:yes
    }
    $PSDriveName8 = Get-PSDrive | Where-Object Name -EQ "K"
    if ($PSDriveName8.Name -match "$DriveLetterCheck8") {
        Write-Verbose -Message "$DriveLetterCheck8 Drive found...remapping drive..." -Verbose
        net use K: /delete
        Start-Sleep -Seconds 8
        net use K: "\\Server\Folder" /persistent:yes
    }
    #Restarts File Explorer as if it is open when this script runs, it may not show them until it is closed and reopened.
    Start-Sleep -Seconds 8
    taskkill /f /im explorer.exe
    Start-Process explorer.exe
}
### Checks for a specific drive letter. If found, it deletes the old letter, maps the new one and stops/starts File Explorer.
Redo-DriveMapping