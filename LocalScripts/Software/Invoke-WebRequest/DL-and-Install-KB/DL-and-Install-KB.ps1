#Global Variabels

#Disabled Invove-WebReqests progress bar speeding up the download. Bug seen here https://github.com/PowerShell/PowerShell/issues/2138

$ProgressPreference = 'SilentlyContinue'

#Download URI

$Global:URI = 'https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2021/01/windows10.0-kb4589210-v2-x64_bbbf54336d6e22da5de8d63891401d8f6077d2ce.msu'

#Full name of the installer.

$Global:MSUName = 'windows10.0-kb4589210-v2-x64_bbbf54336d6e22da5de8d63891401d8f6077d2ce.msu'

#Out-File location.

$Global:OutFile = "C:\$MSUName"

$Global:ExpandLocation = "C:\"

$Global:CABName = 'Windows10.0-KB4589210-v2-x64.cab'

$Global:CABLocation = "C:\$Global:CABName"


$TestPath = Test-Path -Path "$Global:OutFile"

if ($TestPath -ne "True") {
    try {

        #Checks if link is broken.

        Write-Verbose -Message "Checking download link..." -Verbose

        $InvokeWeb = Invoke-WebRequest -Method Head -URI "$Global:URI" -UseBasicParsing

        if ($InvokeWeb.StatusDescription -eq "OK") {
            Write-Verbose -Message "Download link good!" -Verbose
        }else
        {
            Throw "Check download link..."
        }

        #Downloads Program via web.

        Write-Verbose -Message "Downloading .msi installer for $Global:MSUName..." -Verbose

        Invoke-WebRequest -URI "$Global:URI" -OutFile "$Global:OutFile" -UseBasicParsing

        #Checks if the file downloaded.

        do { 
            $TestPath = Test-Path -Path "$Global:OutFile"
            if ($TestPath -ne 'True') {
                Write-Verbose -Message "Downloading $Global:MSUName...Please wait" -Verbose
        
                Start-Sleep -Seconds 5

            }
        }Until ($TestPath -eq 'True')

            Write-Verbose -Message "$Global:MSUName downloaded!" -Verbose
        }
    catch {
        Write-Verbose -Message "Failed install...$Error"    
    }
}else {

    #Install Program from URI.

    try {
        Write-Verbose -Message "$Global:MSUName is already downloaded...Installing...Please wait..." -Verbose

        dism.exe /online /add-package /packagepath:"$Global:OutFile"

        Dism /Add-Package /PackagePath:$Global:OutFile

        Add-WindowsPackage -Online -PackagePath "$Global:OutFile"

        expand -f:* "$Global:OutFile" $Global:ExpandLocation

        Add-WindowsPackage -Online -PackagePath "c:\packages\package.cab"

        dism.exe /online /add-package /packagepath:"$Global:CABLocation"
    }catch {
        Write-Verbose -Message "Install error for , see C:\Windows\Logs\DISM for more info." -Verbose
    }

    #Install check and TEMP file delete.

    do { 
        $TestPath = Test-Path -Path "$ProgramPath"
        if ($TestPath -ne 'True') {
            Write-Host "$Global:MSUName installer is running...Please wait"
        
            Start-Sleep -Seconds 5

        }
    }Until ($TestPath -eq 'True')

    Write-Host "$Global:MSUName installed!"

    Remove-Item "$OutFile"
}

