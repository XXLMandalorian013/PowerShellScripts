    #ReadMe
<#
  
If-ElseIf-Else

## Links

[OnlineVersion](https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2)


#>

#Script


#if

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

if ($PSMainFolder -eq 'True')
{
    Write-Host "C:\PS Exsists..."
    
    if ($PSCoreFolder -eq 'True')
    {
        Write-Host "C:\PS\PSCore Exsists..."
    }
    else
    {
        Write-Host "C:\PS\PSCore not found, creating..."
        New-Item -Path "c:\PS\" -Name "PSCore" -ItemType "directory"

    }
   
}
else
{
    Write-Host "C:\PS not found, creating..."
    New-Item -Path "c:\" -Name "PS" -ItemType "directory"

    if ($PSCoreFolder -eq 'True')
    {
        Write-Host "C:\PS\PSCore Exsists..."
    }
    else
    {
        Write-Host "C:\PS\PSCore not found, creating..."
        New-Item -Path "c:\PS\" -Name "PSCore" -ItemType "directory"

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



#If/throw

if ( $process = Get-Process Notepad* )
{
    Throw
}

