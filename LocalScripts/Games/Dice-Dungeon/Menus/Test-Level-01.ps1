Write-Information -MessageData "Dice Dungeon" -InformationAction Continue
Write-Information -MessageData "Hello adventurer. Please pick an option" -InformationAction Continue
#Function to show the options menu.
function Show-Menu {
    param (
        [string]$Title = 'Menu'
    )
    Write-Host "===== $Title ====="
    Write-Host "1: Press '1' for this option."
    Write-Host "2: Press '2' for this option."
    Write-Host "3: Press '3' for this option."
    Write-Host "Q: Press 'Q' to quit."
}

Show-Menu -Title 'My Menu'
$selection = Read-Host "Enter your selection"

switch ($selection) {
    '1' { 'You chose option #1' }
    '2' { 'You chose option #2' }
    '3' { 'You chose option #3' }
    'q' { return }
}
