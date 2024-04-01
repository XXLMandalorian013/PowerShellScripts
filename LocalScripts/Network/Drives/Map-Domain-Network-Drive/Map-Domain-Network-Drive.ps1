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
        Name           Used (GB)     Free (GB) Provider      Root                                               CurrentLocation
         ----           ---------     --------- --------      ----                                               ---------------
         q                2672.54        119.21 FileSystem    \\Server\Folder
        

    .LINK
        
        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-psdrive?view=powershell-7.2

#>

#Script

# Prejoined domain and domain profile added use only     $Domain = [System.DirectoryServices.ActiveDirectory.Domain]::GetComputerDomain() | Select-Object 'Forest'

$Domain = 'domain.com'

$UserName = $env:UserName

$Cred = Get-Credential -Credential $Domain\$UserName

$DriveLetter = Read-Host 'Enter driver letter you wish to map.'

New-PSDrive -name "$DriveLetter" -psprovider 'FileSystem' -root '\\Server\Folder' -Credential $Cred -Persist