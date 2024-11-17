#Creates a folder/file and add data/cmds to the file.
function Copy-NinaRMMAgentServiceScript {
    param (
        $BaseDirPath = "C:\",
        $DirName = "Ninja-Service-Script",
        $CombinedDirPaths = "$BaseDirPath\$DirName",
        $FileName = "NinjaRMMAgent-Service-Script.ps1",
        $CombinedDirsNFilePath = "$CombinedDirPaths\$FileName"
    )
    #Creates the Dir.
    try {
        $TestPath = Test-Path -Path "$CombinedDirPaths" -ErrorAction SilentlyContinue
        $PreferecCondition = "True"
        if ("$TestPath" -match "$PreferecCondition") {
            Write-Verbose -Message "$CombinedDirPaths already exsist...Moving to next step." -Verbose
        }else {
            New-Item -Path "$BaseDirPath" -Name "$DirName" -ItemType "directory"
        }
    }catch {
    Get-Error -Newest 1
    }
    #PS Array to add data/cmds to a file. Note the ' ' must be at the start and end of each section.
    $data = @(
        '$ServiceName = "NinjaRMMAgent"'

        '$TestService = Get-Service -Name "$ServiceName" -ErrorAction SilentlyContinue'

        '$PreferedServiceStatus = "Running"'

        'if ($PreferedServiceStatus -match $TestService.Status) {
            Write-Verbose -Message "$ServiceName is running...all is good." -Verbose
        }else {
            Write-Verbose -Message "$ServiceName is not running...starting service." -Verbose
            Start-Service -Name "$ServiceName"
            Get-Service -Name "$ServiceName"
        }'
    )
    #Creates the file and adds the data/cmds.
    try {
        $TestPath2 = Test-Path -Path "$CombinedDirsNFilePath" -ErrorAction SilentlyContinue
        $PreferecCondition2 = "True"
        if ("$TestPath2" -match "$PreferecCondition2") {
            Write-Verbose -Message "$CombinedDirsNFilePath already exsist...ending script..." -Verbose
        }else {
            New-Item -Path "$CombinedDirPaths" -Name "$FileName" -ItemType "File"
            Add-Content -Path $CombinedDirsNFilePath -Value $data
            Write-Verbose -Message "script has finished..." -Verbose
        }
    }catch {
        Get-Error -Newest 1
    }
}
#Creates a folder/file and add data/cmds to the file.
Copy-NinaRMMAgentServiceScript