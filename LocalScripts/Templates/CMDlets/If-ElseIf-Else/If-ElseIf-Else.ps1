    #ReadMe
<#
    


#>

#Script


#if

$Path = C:\
if (Test-Path -Path $Path)


#iff

if ( $process = Get-Process Notepad* )
{
    $process | Stop-Process
}


#else

$PS2State = Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root | Select-Object 'State'

if ( $PS2State -eq 'Enabled' )
{
    Write-Host "Disabling PowerShell 2.0"
    
    Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root

    Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root | Select-Object 'State'
}
else
{
    Write-Host "PowerShell 2.0 is already disabled."
}



#Nested if

$Path = C:\

if ( Test-Path -Path $Path -PathType Leaf )
{
    Move-Item -Path $Path -Destination C:\Users
}
else
{
    if ( Test-Path -Path $Path )
    {
        Write-Warning "A file was required but a directory was found instead."
    }
    else
    {
        Write-Warning "$path could not be found."
    }
}



#elseif

$Path = C:\

if ( Test-Path -Path $Path -PathType Leaf )
{
    Move-Item -Path $Path -Destination C:\Users
}
elseif ( Test-Path -Path $Path )
{
    Write-Warning "A file was required but a directory was found instead."
}
else
{
    Write-Warning "$path could not be found."
}





