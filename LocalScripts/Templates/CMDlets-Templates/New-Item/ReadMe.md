# New-Item

* Reference

Module:[Microsoft.PowerShell.Management](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/?view=powershell-7.2)

Creates a new item.

## Syntax

**PowerShell**Copy

```
New-Item
   [-Path] <String[]>
   [-ItemType <String>]
   [-Value <Object>]
   [-Force]
   [-Credential <PSCredential>]
   [-WhatIf]
   [-Confirm]
   [<CommonParameters>]
```

**PowerShell**Copy

```
New-Item
   [[-Path] <String[]>]
   -Name <String>
   [-ItemType <String>]
   [-Value <Object>]
   [-Force]
   [-Credential <PSCredential>]
   [-WhatIf]
   [-Confirm]
   [<CommonParameters>]
```

## Description

The `New-Item` cmdlet creates a new item and sets its value. The types of items that can be created depend on the location of the item. For example, in the file system, `New-Item` creates files and folders. In the registry, `New-Item` creates registry keys and entries.

`New-Item` can also set the value of the items that it creates. For example, when it creates a new file, `New-Item` can add initial content to the file.

## Examples

### Example 1: Create a file in the current directory

This command creates a text file that is named "testfile1.txt" in the current directory. The dot ('.') in the value of the **Path** parameter indicates the current directory. The quoted text that follows the **Value** parameter is added to the file as content.

**PowerShell**Copy

```
New-Item -Path . -Name "testfile1.txt" -ItemType "file" -Value "This is a text string."
```

### Example 2: Create a directory

This command creates a directory named "Logfiles" in the `C:` drive. The **ItemType** parameter specifies that the new item is a directory, not a file or other file system object.

**PowerShell**Copy

```
New-Item -Path "c:\" -Name "logfiles" -ItemType "directory"
```

### Example 3: Create a profile

This command creates a PowerShell profile in the path that is specified by the `$profile` variable.

You can use profiles to customize PowerShell. `$profile` is an automatic (built-in) variable that stores the path and file name of the "CurrentUser/CurrentHost" profile. By default, the profile does not exist, even though PowerShell stores a path and file name for it.

In this command, the `$profile` variable represents the path of the file. **ItemType** parameter specifies that the command creates a file. The **Force** parameter lets you create a file in the profile path, even when the directories in the path do not exist.

After you create a profile, you can enter aliases, functions, and scripts in the profile to customize your shell.

For more information, see [about_Automatic_Variables](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables?view=powershell-7.2) and [about_Profiles](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.2).

**PowerShell**Copy

```
New-Item -Path $profile -ItemType "file" -Force
```

### Example 4: Create a directory in a different directory

This example creates a new Scripts directory in the "C:\PS-Test" directory.

The name of the new directory item, "Scripts", is included in the value of **Path** parameter, instead of being specified in the value of  **Name** . As indicated by the syntax, either command form is valid.

**PowerShell**Copy

```
New-Item -ItemType "directory" -Path "c:\ps-test\scripts"
```

### Example 5: Create multiple files

This example creates files in two different directories. Because **Path** takes multiple strings, you can use it to create multiple items.

**PowerShell**Copy

```
New-Item -ItemType "file" -Path "c:\ps-test\test.txt", "c:\ps-test\Logs\test.log"
```

### Example 6: Use wildcards to create files in multiple directories

The `New-Item` cmdlet supports wildcards in the **Path** parameter. The following command creates a `temp.txt` file in all of the directories specified by the wildcards in the **Path** parameter.

**PowerShell**Copy

```
Get-ChildItem -Path C:\Temp\

Directory:  C:\Temp

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d-----        5/15/2019   6:45 AM        1   One
d-----        5/15/2019   6:45 AM        1   Two
d-----        5/15/2019   6:45 AM        1   Three

New-Item -Path C:\Temp\* -Name temp.txt -ItemType File | Select-Object FullName

FullName
--------
C:\Temp\One\temp.txt
C:\Temp\Three\temp.txt
C:\Temp\Two\temp.txt
```

The `Get-ChildItem` cmdlet shows three directories under the `C:\Temp` directory. Using wildcards the `New-Item` cmdlet creates a `temp.txt` file in all of the directories under the current directory. The `New-Item` cmdlet outputs the items you created, which is piped to `Select-Object` to verify the paths of the newly created files.

### Example 7: Create a symbolic link to a file or folder

This example creates a symbolic link to the Notice.txt file in the current folder.

**PowerShell**Copy

```
$link = New-Item -ItemType SymbolicLink -Path .\link -Target .\Notice.txt
$link | Select-Object LinkType, Target

LinkType     Target
--------     ------
SymbolicLink {.\Notice.txt}
```

In this example, **Target** is an alias for the **Value** parameter. The target of the symbolic link can be a relative path. Prior to PowerShell v6.2, the target must be a fully-qualified path.

Beginning in PowerShell 7.1, you can now create to a **SymbolicLink** to a folder on Windows using a relative path.

### Example 8: Use the -Force parameter to attempt to recreate folders

This example creates a folder with a file inside. Then, attempts to create the same folder using `-Force`. It will not overwrite the folder but simply return the existing folder object with the file created intact.

**PowerShell**Copy

```
PS> New-Item -Path .\TestFolder -ItemType Directory
PS> New-Item -Path .\TestFolder\TestFile.txt -ItemType File

PS> New-Item -Path .\TestFolder -ItemType Directory -Force

    Directory: C:\
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----         5/1/2020   8:03 AM                TestFolder

PS> Get-ChildItem .\TestFolder\

    Directory: C:\TestFolder
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         5/1/2020   8:03 AM              0 TestFile.txt
```

### Example 9: Use the -Force parameter to overwrite existing files

This example creates a file with a value and then recreates the file using `-Force`. This overwrites The existing file and it will lose it's content as you can see by the length property

**PowerShell**Copy

```
PS> New-Item ./TestFile.txt -ItemType File -Value 'This is just a test file'

    Directory: C:\Source\Test
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         5/1/2020   8:32 AM             24 TestFile.txt

New-Item ./TestFile.txt -ItemType File -Force

    Directory: C:\Source\Test
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         5/1/2020   8:32 AM              0 TestFile.txt
```

 Note

When using `New-Item` with the `-Force` switch to create registry keys, the command will behave the same as when overwriting a file. If the registry key already exists, the key and all properties and values will be overwritten with an empty registry key.

## Parameters

-Confirm

Prompts you for confirmation before running the cmdlet.

| Type:                       | [SwitchParameter](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.switchparameter) |
| --------------------------- | -------------------------------------------------------------------------------------------------------- |
| Aliases:                    | cf                                                                                                       |
| Position:                   | Named                                                                                                    |
| Default value:              | False                                                                                                    |
| Accept pipeline input:      | False                                                                                                    |
| Accept wildcard characters: | False                                                                                                    |

-Credential

 Note

This parameter is not supported by any providers installed with PowerShell. To impersonate another user or elevate your credentials when running this cmdlet, use `Invoke-Command`.

| Type:                       | [PSCredential](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.pscredential) |
| --------------------------- | -------------------------------------------------------------------------------------------------- |
| Position:                   | Named                                                                                              |
| Default value:              | Current user                                                                                       |
| Accept pipeline input:      | True                                                                                               |
| Accept wildcard characters: | False                                                                                              |

-Force

Forces this cmdlet to create an item that writes over an existing read-only item. Implementation varies from provider to provider. Even using the **Force** parameter, the cmdlet cannot override security restrictions.

| Type:                       | [SwitchParameter](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.switchparameter) |
| --------------------------- | -------------------------------------------------------------------------------------------------------- |
| Position:                   | Named                                                                                                    |
| Default value:              | None                                                                                                     |
| Accept pipeline input:      | False                                                                                                    |
| Accept wildcard characters: | False                                                                                                    |

-ItemType

Specifies the provider-specified type of the new item. The available values of this parameter depend on the current provider you are using.

If your location is in a `FileSystem` drive, the following values are allowed:

* File
* Directory
* SymbolicLink
* Junction
* HardLink

 Note

Creating a `SymbolicLink` type on Windows requires elevation as administrator. However, Windows 10 (build 14972 or newer) with Developer Mode enabled no longer requires elevation creating symbolic links.

In a `Certificate` drive, these are the values you can specify:

* Certificate Provider
* Certificate
* Store
* StoreLocation

For more information see [about_Providers](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-7.2).

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string) |
| --------------------------- | ---------------------------------------------------------------- |
| Aliases:                    | Type                                                             |
| Position:                   | Named                                                            |
| Default value:              | None                                                             |
| Accept pipeline input:      | True                                                             |
| Accept wildcard characters: | False                                                            |

-Name

Specifies the name of the new item. You can specify the name of the new item in the **Name** or **Path** parameter value, and you can specify the path of the new item in **Name** or **Path** value. Items names passed using the **Name** parameter are created relative to the value of the **Path** parameter.

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string) |
| --------------------------- | ---------------------------------------------------------------- |
| Position:                   | Named                                                            |
| Default value:              | None                                                             |
| Accept pipeline input:      | True                                                             |
| Accept wildcard characters: | False                                                            |

-Path

Specifies the path of the location of the new item. The default is the current location when **Path** is omitted. You can specify the name of the new item in  **Name** , or include it in  **Path** . Items names passed using the **Name** parameter are created relative to the value of the **Path** parameter.

For this cmdlet, the **Path** parameter works like the **LiteralPath** parameter of other cmdlets. Wildcard characters are not interpreted. All characters are passed to the location's provider. The provider may not support all characters. For example, you cannot create a filename that contains an asterisk (`*`) character.

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string)[] |
| --------------------------- | ------------------------------------------------------------------ |
| Position:                   | 0                                                                  |
| Default value:              | Current location                                                   |
| Accept pipeline input:      | True                                                               |
| Accept wildcard characters: | False                                                              |

-Value

Specifies the value of the new item. You can also pipe a value to `New-Item`.

| Type:                       | [Object](https://docs.microsoft.com/en-us/dotnet/api/system.object) |
| --------------------------- | ---------------------------------------------------------------- |
| Aliases:                    | Target                                                           |
| Position:                   | Named                                                            |
| Default value:              | None                                                             |
| Accept pipeline input:      | True                                                             |
| Accept wildcard characters: | False                                                            |

-WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

| Type:                       | [SwitchParameter](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.switchparameter) |
| --------------------------- | -------------------------------------------------------------------------------------------------------- |
| Aliases:                    | wi                                                                                                       |
| Position:                   | Named                                                                                                    |
| Default value:              | False                                                                                                    |
| Accept pipeline input:      | False                                                                                                    |
| Accept wildcard characters: | False                                                                                                    |

## Inputs

**[Object](https://docs.microsoft.com/en-us/dotnet/api/system.object)**

You can pipe a value for the new item to this cmdlet.

## Outputs

**[Object](https://docs.microsoft.com/en-us/dotnet/api/system.object)**

This cmdlet returns the item that it creates.

## Notes

`New-Item` is designed to work with the data exposed by any provider. To list the providers available in your session, type `Get-PsProvider`. For more information, see [about_Providers](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-7.2).

## Related Links

* [Online Version](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.2)
* [Clear-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/clear-item?view=powershell-7.2)
* [Copy-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item?view=powershell-7.2)
* [Get-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-item?view=powershell-7.2)
* [Invoke-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/invoke-item?view=powershell-7.2)
* [Move-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/move-item?view=powershell-7.2)
* [Remove-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.2)
* [Rename-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-item?view=powershell-7.2)
* [Set-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-item?view=powershell-7.2)
* [about_Providers](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-7.2)
