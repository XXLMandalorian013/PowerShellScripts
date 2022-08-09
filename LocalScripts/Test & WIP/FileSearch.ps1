$Path = Read-Host -Prompt "Please enter the file location you want to search"

$FilePath = Read-Host -Prompt "Please type an astrics for all files or a posible file name ie test.docx"


Get-ChildItem -Path $Path -Recurse -file -Force -ErrorAction SilentlyContinue -include $FileName | Select-Object FullName


Get-ChildItem -Path C:/ -Recurse -file -Force -ErrorAction SilentlyContinue -include *


$Dir = Read-Host -Prompt "Please enter a directory."

$FileNameOrExtention = Read-Host -Prompt "Please type an * for all files or a posible file name w/ file type ie test.docx"

Get-ChildItem -Path $Dir -include $FileNameOrExtention | Sort-Object -Property {$_.Directory - $_.Name}
