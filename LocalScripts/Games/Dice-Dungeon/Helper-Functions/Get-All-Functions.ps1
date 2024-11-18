Function Get-AllFunctions {
    param (
        [string]$FolderPath = "C:\Users\XXLMandalorian\Desktop\Dice-Dungeon"
    )
    if (-Not (Test-Path $FolderPath)) {
        Write-Error "Folder path '$FolderPath' does not exist."
        return
    }
    $functionNames = @()
    Get-ChildItem -Path $FolderPath -Recurse -Include *.psm1 | ForEach-Object {
        $fileContent = Get-Content -Path $_.FullName -Raw
        $functionsInFile = $fileContent | Select-String -Pattern "Function\s+([^\s{]+)" -AllMatches | ForEach-Object {
            $_.Matches.Groups[1].Value
        }
        $functionNames += $functionsInFile
    }
    return $functionNames
}
Get-AllFunctions