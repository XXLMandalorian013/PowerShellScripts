if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Error "This script DOES NOT requires Administrator rights. To run this cmdlet, start PowerShell unelevated."
    return
}



