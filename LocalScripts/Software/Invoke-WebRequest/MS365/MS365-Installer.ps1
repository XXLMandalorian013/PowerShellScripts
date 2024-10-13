#ReadMe
<#

Office-Installer.ps1

.SYNOPSIS

Installs office based off an .xml file created from a tenant inside the office congiurator.

.Notes

Note, the .xml file can spcify an uninstall.

.INPUTS

None.

.OUTPUTS

System.Strings

.LINK

[Write-Verbose](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-verbose?view=powershell-7.3)

[about_If](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.3)

[about_Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7.3)

[about_Try_Catch_Finally](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.3)

[Approved Verbs for PowerShell Commands](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3)

[about_Operators](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.3)

[about_Throw](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_throw?view=powershell-7.3)

[about_Do](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.3)

[Expand-Archive](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.archive/expand-archive?view=powershell-7.4)

[New-Item] (https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.4)

[office congiruator to site to create xlm intaller] (https://config.office.com/)

[Office configurator site Doc] (https://learn.microsoft.com/en-us/microsoft-365-apps/admin-center/overview-office-customization-tool)

[Office deployment tool download] (https://www.microsoft.com/en-us/download/details.aspx?id=49117)

[Office deployment tool doc] (https://learn.microsoft.com/en-us/microsoft-365-apps/deploy/overview-office-deployment-tool)

#>

#Script
#Region Start-Script
#Letting the user know what is starting.
function Start-ScriptBoilerplate {
    $ScriptName = "Office-Installer.ps1"
    $ScriptAuthor = "DAM"
    $WrittenDate = "2024-10-12"
    $ModifiedDate = "never"
    $ScriptBoilerplate = "$ScriptName script starting...written by $ScriptAuthor on $WrittenDate, last modified on $ModifiedDate"
    Write-Verbose -Message "$ScriptBoilerplate" -Verbose
}
#Checks if the terminal is runing as admin/elevated as Invoke-WebRequest will not run without it.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Throw "This script requires Administrator rights. To run this script, start PowerShell with the `"Run as administrator`" option."
}
#Creates a folder/file and add data/cmds to the file.
function New-XLMConfig {
    param (
        $BaseDirPath = "C:",
        $DirName = "Office-Installer",
        $FileName = "MS-Office-Install.xml"
    )
    #PS Array to add data/cmds to a file. Note the ' ' must be at the start and end of the code.
    $data = @(
        {
        <Configuration ID="12345-123-1234-aaaa-234552">
            <Info Description="This will uninstall any existing office apps and install new MS365 office apps. This is a user based licensing deployment and the EULA has already been accepted." />
            <Add OfficeClientEdition="64" Channel="Current">
                <Product ID="O365BusinessRetail">
            <Language ID="en-us" />
            <ExcludeApp ID="Access" />
            <ExcludeApp ID="Groove" />
            <ExcludeApp ID="Lync" />
            <ExcludeApp ID="Publisher" />
            </Product>
        </Add>
        <Property Name="SharedComputerLicensing" Value="0" />
        <Property Name="FORCEAPPSHUTDOWN" Value="FALSE" />
        <Property Name="DeviceBasedLicensing" Value="0" />
        <Property Name="SCLCacheOverride" Value="0" />
        <Property Name="TenantId" Value="da5931f8-f7e5-4fa7-9778-f5616b60f8dc" />
        <Updates Enabled="TRUE" />
        <RemoveMSI />
        <AppSettings>
            <User Key="software\microsoft\office\16.0\excel\options" Name="defaultformat" Value="51" Type="REG_DWORD" App="excel16" Id="L_SaveExcelfilesas" />
            <User Key="software\microsoft\office\16.0\powerpoint\options" Name="defaultformat" Value="27" Type="REG_DWORD" App="ppt16" Id="L_SavePowerPointfilesas" />
            <User Key="software\microsoft\office\16.0\word\options" Name="defaultformat" Value="" Type="REG_SZ" App="word16" Id="L_SaveWordfilesas" />
        </AppSettings>
        <Display Level="Full" AcceptEULA="TRUE" />
        </Configuration>
        }
    )
    #Creates the Dir.
    cd C:\
    try {
        $TestPath = Test-Path -Path "$BaseDirPath\$DirName" -ErrorAction SilentlyContinue
        $PreferecCondition = "True"
        if ("$TestPath" -match "$PreferecCondition") {
            Write-Verbose -Message "$BaseDirPath\$DirName already exsist...Moving to next step." -Verbose
        }else {
            New-Item -Path "$BaseDirPath" -Name "$DirName" -ItemType "Directory"
        }
    }catch {
        Get-Error -Newest 1
    }
        #Creates the file and adds the data/cmds.
        try {
            $TestPath2 = Test-Path -Path "$BaseDirPath\$DirName\$FileName" -ErrorAction SilentlyContinue
            $PreferecCondition2 = "True"
            if ("$TestPath2" -match "$PreferecCondition2") {
                Write-Verbose -Message "$BaseDirPath\$DirName\$FileName already exsist...Moving to next step." -Verbose
            }else {
                cd C:\
                New-Item -Path "$BaseDirPath\$DirName" -Name "$FileName" -ItemType "File"
                Add-Content -Path "$BaseDirPath\$DirName\$FileName" -Value $data
            }
        }
        catch {
            Get-Error -Newest 1
        }
}
#Installs the program.
function Install-Office {
    param (
        #Installer URL
        $URI = "https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_17830-20162.exe", 
        $BaseDirPath = "C:",
        $DirName = "Office-Installer",
        #Full name of the installer.
        $UninstallerName = 'officedeploymenttool_17830-20162.exe',
        #Full path of the uninstallers.
        $OutFile = "C:\$DirName\$UninstallerName",
        #Office Installer Tool Name.
        $ToolName = "setup.exe",
        $FileName = "MS-Office-Install.xml",
        #Installer name.
        $InstallerName = "$BaseDirPath\$DirName\$ToolName"
    )
        Set-Location -Path "$BaseDirPath\$DirName"
        #Downloads the installer.
        try {
            #Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138
            $ProgressPreference = 'SilentlyContinue'
            Write-Verbose -Message "Downloading $UninstallerName..." -Verbose
            Invoke-WebRequest -URI "$URI" -OutFile "$OutFile" -UseBasicParsing
            Start-Sleep -Seconds 5
        }catch {
            Write-Verbose -Message"$Error[0]" -Verbose
            Write-Verbose -Message"$UninstallerName may not match what is being download anymore?" -Verbose
        }
        #Exctracts the installer.
        try {
            Set-Location -Path "$BaseDirPath\$DirName"
            Write-Verbose -Message "extrating the installer..." -Verbose
            Start-Process -FilePath "$BaseDirPath\$DirName\$UninstallerName" -ArgumentList "/extract:$BaseDirPath\$DirName","/quiet","/norestart"
            Start-Sleep -Seconds 5
        }
        catch {
            Write-Verbose -Message"$Error[0]" -Verbose
        }
        #Runs the installer.
        try {
            Write-Verbose -Message "running the installer..." -Verbose
            Start-Process -FilePath "setup.exe" -ArgumentList "/configure DataTalk-Office-Install.xml"
            Start-Sleep -Seconds 10
        }
        catch {
            Write-Verbose -Message"$Error[0]" -Verbose
        }
}
#Letting the user know what is starting.
Start-ScriptBoilerplate
#Creates the .xml config file.
New-XLMConfig
#Installs the program.
Install-Office
#EndRegion