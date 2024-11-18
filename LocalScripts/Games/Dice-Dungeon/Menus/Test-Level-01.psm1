#Function to show the options menu.
function Show-Menu {
    param (
        [string]$Title = 'Dice-Dungeon'
    )
    Write-Information -MessageData "Dice Dungeon!" -InformationAction Continue
    Write-Information -MessageData "Hello adventurer. Please pick an option" -InformationAction Continue
    Write-Host "===== $Title ====="
    Write-Host "1: Press '1' to start a new game."
    Write-Host "2: Press '2' to read how this game works."
    Write-Host "3: Press '3' to view the playable character sheets."
    Write-Host "Q: Press 'Q' to quit."
}

Show-Menu -Title 'My Menu'
$selection = Read-Host "Enter your selection"

switch ($selection) {
    '1' { 'You chose option #1' }
    '2' { 'You chose option #2' }
    '3' { 'You chose option #3' }
    'q' { exit }
}
