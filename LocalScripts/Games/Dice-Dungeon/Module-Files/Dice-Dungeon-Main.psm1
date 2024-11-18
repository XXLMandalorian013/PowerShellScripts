#Dice-Dungeon.psm1
##Character Classes
Import-Module -Name (Join-Path $PSScriptRoot 'C:\Users\XXLMandalorian\Desktop\Dice-Dungeon\Character-Classes\Rouge.psm1')
##Dice
###D4
Import-Module -Name (Join-Path $PSScriptRoot 'Dice\D4.psm1')
###D10
Import-Module -Name (Join-Path $PSScriptRoot 'Dice\D10.psm1')
###D20
Import-Module -Name (Join-Path $PSScriptRoot 'Dice\D20.psm1')
##Menus
Import-Module -Name (Join-Path $PSScriptRoot 'Menus\Test-Level-01.psm1')
##Monsters
###Goblin
Import-Module -Name (Join-Path $PSScriptRoot 'Monsters\Goblin.psm1')
##Weapons
###Bow-and-Arrows
Import-Module -Name (Join-Path $PSScriptRoot '.\Weapons\Bow-and-Arrows.psm1')
###Bow-and-Arrows
Import-Module -Name (Join-Path $PSScriptRoot '.\Weapons\Dagger.psm1')