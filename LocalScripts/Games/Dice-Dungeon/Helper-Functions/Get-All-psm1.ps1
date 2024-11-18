Function Get-psm1 {
    param (
        [string]$FolderPath = "C:\Users\XXLMandalorian\Desktop\Dice-Dungeon"
    )
    if (-Not (Test-Path $FolderPath)) {
        Write-Error "Folder path '$FolderPath' does not exist."
        return
    }
    # Initialize an array to hold the file names
    $moduleNames = @()
    # Get all .psm1 files recursively in the specified folder
    Get-ChildItem -Path $FolderPath -Recurse -Include *.psm1 | ForEach-Object {
        # Add the file name (without path) to the array
        $moduleNames += $_.Name
    }
    # Return the array of module names
    return $moduleNames
}
# Example usage
Get-psm1
