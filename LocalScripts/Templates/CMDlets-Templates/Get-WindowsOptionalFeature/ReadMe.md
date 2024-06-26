# Get-WindowsOptionalFeature

* Reference

Module:[DISM](https://docs.microsoft.com/en-us/powershell/module/dism/?view=winserver2012r2-ps)

Gets information about optional features in a Windows image.

## Syntax

**PowerShell**

```
Get-WindowsOptionalFeature
   [-FeatureName <String>]
   [-PackageName <String>]
   [-PackagePath <String>]
   -Path <String>
   [-WindowsDirectory <String>]
   [-SystemDrive <String>]
   [-LogPath <String>]
   [-ScratchDirectory <String>]
   [-LogLevel <LogLevel>]
   [<CommonParameters>]
```

**PowerShell**

```
Get-WindowsOptionalFeature
   [-FeatureName <String>]
   [-PackageName <String>]
   [-PackagePath <String>]
   [-Online]
   [-WindowsDirectory <String>]
   [-SystemDrive <String>]
   [-LogPath <String>]
   [-ScratchDirectory <String>]
   [-LogLevel <LogLevel>]
   [<CommonParameters>]
```

## Description

The Get-WindowsOptionalFeature cmdlet gets information about all features (operating system features that include optional Windows foundation features) in the Windows Foundation Package or a specified package in the Windows image.

Use the PackageName or PackagePath parameter to get information about all features in a specific package in the Windows image.

The FeatureName parameter gets more detailed information about a specific feature in the Windows image. If the feature is not a part of the Windows Foundation package, either a PackageName or PackagePath parameter must be used to specify the parent package of the feature.

Use the Online parameter to specify the running operating system on your local computer, or use the Path parameter to specify the location of a mounted Windows image.

## Examples

### Example 1

**PowerShell**Copy

```
PS C:\>Get-WindowsOptionalFeature -Online
```

This command lists all of the optional features in the running Windows operating system.

### Example 2

**PowerShell**Copy

```
PS C:\>Get-WindowsOptionalFeature -Path c:\offline -PackageName Microsoft-Windows-Backup-Package~31bf3856ad364e35~x86~~6.1.7601.16525
```

This command displays lists all of the optional features in the specified package in the Windows image mounted to c:\offline.

### Example 3

**PowerShell**Copy

```
PS C:\>Get-WindowsOptionalFeature -Path c:\offline -FeatureName Hearts
```

This command displays detailed information about the feature, Hearts, in the Windows Foundation Package in the Windows image mounted to c:\offline.

### Example 4

**PowerShell**Copy

```
PS C:\>Get-WindowsOptionalFeature -Path c:\offline -FeatureName MyFeature -PackagePath c:\packages\package.cab
```

This command displays detailed information about the feature, MyFeature, in the package at c:\package\package.cab in the Windows image mounted to c:\offline.

## Parameters

-FeatureName

Specifies the name of a feature to get detailed information about. Feature names are case sensitive if you are servicing a Windows image other than Windows 8.

| Type:                       | **String** |
| --------------------------- | ---------------- |
| Position:                   | Named            |
| Default value:              | None             |
| Accept pipeline input:      | True             |
| Accept wildcard characters: | False            |

-LogLevel

Specifies the maximum output level shown in the logs. The default log level is 3. The accepted values are as follows: 1 = Errors only 2 = Errors and warnings 3 = Errors, warnings, and information 4 = All of the information listed previously, plus debug output

| Type:                       | **LogLevel**             |
| --------------------------- | ------------------------------ |
| Aliases:                    | LL                             |
| Accepted values:            | Errors, Warnings, WarningsInfo |
| Position:                   | Named                          |
| Default value:              | None                           |
| Accept pipeline input:      | True                           |
| Accept wildcard characters: | False                          |

-LogPath

Specifies the full path and file name to log to. If not set, the default is `%WINDIR%\Logs\Dism\dism.log`. In Windows PE, the default directory is the RAMDISK scratch space which can be as low as 32 MB. The log file will automatically be archived. The archived log file will be saved with .bak appended to the file name and a new log file will be generated. Each time the log file is archived the .bak file will be overwritten. When using a network share that is not joined to a domain, use the net use command together with domain credentials to set access permissions before you set the log path for the DISM log.

| Type:                       | **String** |
| --------------------------- | ---------------- |
| Aliases:                    | LP               |
| Position:                   | Named            |
| Default value:              | None             |
| Accept pipeline input:      | True             |
| Accept wildcard characters: | False            |

-Online

Specifies that the action is to be taken on the operating system that is currently running on the local computer.

| Type:                       | **SwitchParameter** |
| --------------------------- | ------------------------- |
| Position:                   | Named                     |
| Default value:              | None                      |
| Accept pipeline input:      | True                      |
| Accept wildcard characters: | False                     |

-PackageName

Specifies the name of a package as it is listed in the Windows image. Use the PackageName parameter to get all of the features in the package. Use the FeatureName and PackageName parameters to get more detailed information about a specific feature in the package.

| Type:                       | **String** |
| --------------------------- | ---------------- |
| Position:                   | Named            |
| Default value:              | None             |
| Accept pipeline input:      | True             |
| Accept wildcard characters: | False            |

-PackagePath

Specifies the location of a .cab file in the Windows image. Use the PackagePath parameter to get all of the features in the package. Use the FeatureName and PackagePath parameters to get more detailed information about a specific feature in the package.

| Type:                       | **String** |
| --------------------------- | ---------------- |
| Position:                   | Named            |
| Default value:              | None             |
| Accept pipeline input:      | True             |
| Accept wildcard characters: | False            |

-Path

Specifies the full path to the root directory of the offline Windows image that you will service. If the directory named Windows is not a subdirectory of the root directory, -WindowsDirectory must be specified.

| Type:                       | **String** |
| --------------------------- | ---------------- |
| Position:                   | Named            |
| Default value:              | None             |
| Accept pipeline input:      | True             |
| Accept wildcard characters: | False            |

-ScratchDirectory

Specifies a temporary directory that will be used when extracting files for use during servicing. The directory must exist locally. If not specified, the `\Windows\%Temp%` directory will be used, with a subdirectory name of a randomly generated hexadecimal value for each run of DISM. Items in the scratch directory are deleted after each operation. You should not use a network share location as a scratch directory to expand a package (.cab or .msu file) for installation. The directory used for extracting files for temporary usage during servicing should be a local directory.

| Type:                       | **String** |
| --------------------------- | ---------------- |
| Position:                   | Named            |
| Default value:              | None             |
| Accept pipeline input:      | True             |
| Accept wildcard characters: | False            |

-SystemDrive

Specifies the path to the location of the BootMgr files. This is necessary only when the BootMgr files are located on a partition other than the one that you are running the command from. Use -SystemDrive to service an installed Windows image from a Windows PE environment.

| Type:                       | **String** |
| --------------------------- | ---------------- |
| Position:                   | Named            |
| Default value:              | None             |
| Accept pipeline input:      | True             |
| Accept wildcard characters: | False            |

-WindowsDirectory

Specifies the path to the Windows directory relative to the image path. This cannot be the full path to the Windows directory; it should be a relative path. If not specified, the default is the Windows directory in the root of the offline image directory.

| Type:                       | **String** |
| --------------------------- | ---------------- |
| Position:                   | Named            |
| Default value:              | None             |
| Accept pipeline input:      | True             |
| Accept wildcard characters: | False            |

## Inputs

**[String](https://docs.microsoft.com/en-us/dotnet/api/system.string)[]**

**Microsoft.Dism.Commands.ImageObject**

## Outputs

**Microsoft.Dism.Commands.BasicFeatureObject**

**Microsoft.Dism.Commands.AdvancedFeatureObject**

## Related Links

* [OnlineVersion](https://docs.microsoft.com/en-us/powershell/module/dism/get-windowsoptionalfeature?view=winserver2012r2-ps&redirectedfrom=MSDN)
* [Add-WindowsPackage](https://docs.microsoft.com/en-us/powershell/module/dism/add-windowspackage?view=winserver2012r2-ps)
* [Enable-WindowsOptionalFeature](https://docs.microsoft.com/en-us/powershell/module/dism/enable-windowsoptionalfeature?view=winserver2012r2-ps)
* [Get-WindowsPackage](https://docs.microsoft.com/en-us/powershell/module/dism/get-windowspackage?view=winserver2012r2-ps)
