#The following functions create a script and a scheduled task set to run when the device start up and start the NinjaRMMAgent service if it is not already.
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
    #PS Array to add data/cmds to a file. Note the ' ' must be at the start and end of the code.
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
##Creates a folder/file and add data/cmds to the file.
function Copy-NinaRMMAgentScheduledTask {
    param (
        $BaseDirPath = "C:\",
        $DirName = "Ninja-Service-Script",
        $CombinedDirPaths = "$BaseDirPath\$DirName",
        $FileName = "NinjaRMMAgent-Check.xml",
        $CombinedDirsNFilePath = "$CombinedDirPaths\$FileName"
    )
    #Creates the Dir.
    try {
        $TestPath = Test-Path -Path "$CombinedDirPaths" -ErrorAction SilentlyContinue
        $PreferedCondition = "True"
        if ("$TestPath" -match "$PreferedCondition") {
            Write-Verbose -Message "$CombinedDirPaths already exsist...Moving to next step." -Verbose
        }else {
            New-Item -Path "$BaseDirPath" -Name "$DirName" -ItemType "directory"
        }
    }catch {
    Get-Error -Newest 1
    }
    #PS Array to add data/cmds to a file. Note the ' ' must be at the start and end of the code.
    $data = @(
        '<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.3" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Date>2024-09-16T12:25:18.3637812</Date>
    <Author>CHEF-LAPTOP-03\Drew</Author>
    <Description>Checks to see if the NinjaRMMAgent service is running, if not, it starts it.</Description>
    <URI>\NinjaRMMAgent Check</URI>
  </RegistrationInfo>
  <Triggers>
    <BootTrigger>
      <Enabled>true</Enabled>
      <Delay>PT30S</Delay>
    </BootTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <UserId>S-1-5-18</UserId>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>true</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>true</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>true</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
    <WakeToRun>true</WakeToRun>
    <ExecutionTimeLimit>PT1H</ExecutionTimeLimit>
    <Priority>7</Priority>
    <RestartOnFailure>
      <Interval>PT1M</Interval>
      <Count>3</Count>
    </RestartOnFailure>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>powershell.exe</Command>
      <Arguments>-NoProfile -ExecutionPolicy Bypass -File "C:\Ninja-Service-Script\NinjaRMMAgent-Service-Script.ps1"</Arguments>
    </Exec>
  </Actions>
</Task>'
    )
    #Creates the file and adds the data/cmds.
    try {
        $TestPath2 = Test-Path -Path "$CombinedDirsNFilePath" -ErrorAction SilentlyContinue
        $PreferedCondition = "True"
        if ("$TestPath2" -match "$PreferedCondition") {
            Write-Verbose -Message "$CombinedDirsNFilePath already exsist...ending script..." -Verbose
        }else {
            New-Item -Path "$CombinedDirPaths" -Name "$FileName" -ItemType "File"
            Add-Content -Path $CombinedDirsNFilePath -Value $data
            Write-Verbose -Message "Copy-NinaRMMAgentScheduledTask has finished..." -Verbose
        }
    }catch {
        Get-Error -Newest 1
    }
}
##Imports the scheduled task.
function Import-NinaRMMAgentScheduledTask {
    param (
        $BaseDirPath = "C:\",
        $DirName = "Ninja-Service-Script",
        $CombinedDirPaths = "$BaseDirPath\$DirName",
        $FileName = "NinjaRMMAgent-Check.xml",
        $CombinedDirsNFilePath = "$CombinedDirPaths\$FileName",
        $TaskName = "NinjaRMMAgent Check"
    )
    try {
      $GetTask = Get-ScheduledTask -TaskName "$PreferedTaskName" -ErrorAction SilentlyContinue
      $PreferedTaskName = "NinjaRMMAgent Check"
      if ("$GetTask.TaskName" -match "$PreferedTaskName") {
        Write-Verbose -Message "$TaskName Scheduled task already exsists...ending step" -Verbose
      }else {
        #Grabs the .xml for task scheduler to import.
        $XMLContent = Get-Content "$CombinedDirsNFilePath" | Out-String
        #Register the scheduled task into Task Scheduler
        Register-ScheduledTask -Xml $XMLContent -TaskName "$TaskName"
      }
    }
    catch {
      Get-Error -Newest 1
    }
    
}
#Creates a folder/file and add data/cmds to the file.
Copy-NinaRMMAgentServiceScript
##Creates a folder/file and add data/cmds to the file.
Copy-NinaRMMAgentScheduledTask
##Imports the scheduled task.
Import-NinaRMMAgentScheduledTask
