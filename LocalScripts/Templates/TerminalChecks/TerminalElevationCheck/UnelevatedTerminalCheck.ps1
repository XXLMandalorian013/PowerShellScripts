if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Throw "This script DOES NOT requires Administrator rights. To run this script, start PowerShell unelevated."
    
}

