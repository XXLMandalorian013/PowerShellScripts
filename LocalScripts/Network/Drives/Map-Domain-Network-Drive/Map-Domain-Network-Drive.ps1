    #ReadMe
<#
    
    .SYNOPSIS

    Maps a domain network drive.


    .INPUTS
        
        The script grabs the login users name, just imput their credentials.


    .OUTPUTS
        
        PowerShell credential request
        Enter your credentials.
        Password for user \DAM: ************
        

    .LINK
        
        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-psdrive?view=powershell-7.2

#>

#Script

$Domain = 'domain.com'

$UserName = $env:UserName

$Cred = Get-Credential -Credential $Domain\$UserName

New-PSDrive -name 'Q' -psprovider 'FileSystem' -root '\\Server\Folder' -Credential $Cred -Persist