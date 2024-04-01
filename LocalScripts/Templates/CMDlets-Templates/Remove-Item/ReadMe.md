# Remove-Item

* Reference

Module:[Microsoft.PowerShell.Management](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/?view=powershell-7.2)

Deletes the specified items.

## Syntax

**PowerShell**Copy

```
Remove-Item
      [-Path] <String[]>
      [-Filter <String>]
      [-Include <String[]>]
      [-Exclude <String[]>]
      [-Recurse]
      [-Force]
      [-Credential <PSCredential>]
      [-WhatIf]
      [-Confirm]
      [-Stream <String[]>]
      [<CommonParameters>]
```

**PowerShell**Copy

```
Remove-Item
      -LiteralPath <String[]>
      [-Filter <String>]
      [-Include <String[]>]
      [-Exclude <String[]>]
      [-Recurse]
      [-Force]
      [-Credential <PSCredential>]
      [-WhatIf]
      [-Confirm]
      [-Stream <String[]>]
      [<CommonParameters>]
```

## Description

The `Remove-Item` cmdlet deletes one or more items. Because it is supported by many providers, it can delete many different types of items, including files, folders, registry keys, variables, aliases, and functions.

## Examples

### Example 1: Delete files that have any file name extension

This example deletes all of the files that have names that include a dot (`.`) from the `C:\Test` folder. Because the command specifies a dot, the command does not delete folders or files that have no file name extension.

**PowerShell**Copy

```
Remove-Item C:\Test\*.*
```

### Example 2: Delete some of the document files in a folder

This example deletes from the current folder all files that have a `.doc` file name extension and a name that does not include `*1*`.

**PowerShell**Copy

```
Remove-Item * -Include *.doc -Exclude *1*
```

It uses the wildcard character (`*`) to specify the contents of the current folder. It uses the **Include** and **Exclude** parameters to specify the files to delete.

### Example 3: Delete hidden, read-only files

This command deletes a file that is both *hidden* and  *read-only* .

**PowerShell**Copy

```
Remove-Item -Path C:\Test\hidden-RO-file.txt -Force
```

It uses the **Path** parameter to specify the file. It uses the **Force** parameter to delete it. Without  **Force** , you cannot delete *read-only* or *hidden* files.

### Example 4: Delete files in subfolders recursively

This command deletes all of the CSV files in the current folder and all subfolders recursively.

Because the **Recurse** parameter in `Remove-Item` has a known issue, the command in this example uses `Get-ChildItem` to get the desired files, and then uses the pipeline operator to pass them to `Remove-Item`.

**PowerShell**Copy

```
Get-ChildItem * -Include *.csv -Recurse | Remove-Item
```

In the `Get-ChildItem` command, **Path** has a value of (`*`), which represents the contents of the current folder. It uses **Include** to specify the CSV file type, and it uses **Recurse** to make the retrieval recursive. If you try to specify the file type the path, such as `-Path *.csv`, the cmdlet interprets the subject of the search to be a file that has no child items, and **Recurse** fails.

 Note

This behavior was fixed in Windows versions 1909 and up.

### Example 5: Delete subkeys recursively

This command deletes the "OldApp" registry key and all its subkeys and values. It uses `Remove-Item` to remove the key. The path is specified, but the optional parameter name ( **Path** ) is omitted.

The **Recurse** parameter deletes all of the contents of the "OldApp" key recursively. If the key contains subkeys and you omit the **Recurse** parameter, you are prompted to confirm that you want to delete the contents of the key.

**PowerShell**Copy

```
Remove-Item HKLM:\Software\MyCompany\OldApp -Recurse
```

### Example 6: Deleting files with special characters

The following example shows how to delete files that contain special characters like brackets or parentheses.

**PowerShell**Copy

```
Get-ChildItem

Directory: C:\temp\Downloads

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a---          6/1/2018  12:19 PM           1362 myFile.txt
-a---          6/1/2018  12:30 PM           1132 myFile[1].txt
-a---          6/1/2018  12:19 PM           1283 myFile[2].txt
-a---          6/1/2018  12:19 PM           1432 myFile[3].txt

Get-ChildItem | Where-Object Name -Like '*`[*'

Directory: C:\temp\Downloads

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a---          6/1/2018  12:30 PM           1132 myFile[1].txt
-a---          6/1/2018  12:19 PM           1283 myFile[2].txt
-a---          6/1/2018  12:19 PM           1432 myFile[3].txt

Get-ChildItem | Where-Object Name -Like '*`[*' | ForEach-Object { Remove-Item -LiteralPath $_.Name }
Get-ChildItem

Directory: C:\temp\Downloads

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a---          6/1/2018  12:19 PM           1362 myFile.txt
```

### Example 7: Remove an alternate data stream

This example shows how to use the **Stream** dynamic parameter of the `Remove-Item` cmdlet to delete an alternate data stream. The stream parameter is introduced in Windows PowerShell 3.0.

**PowerShell**Copy

```
Get-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier

FileName: \\C:\Test\Copy-Script.ps1

Stream                   Length
------                   ------
Zone.Identifier              26

Remove-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier
Get-Item C:\Test\Copy-Script.ps1 -Stream Zone.Identifier

Get-Item : Could not open alternate data stream 'Zone.Identifier' of file 'C:\Test\Copy-Script.ps1'.
```

The **Stream** parameter `Get-Item` gets the `Zone.Identifier` stream of the `Copy-Script.ps1` file. `Remove-Item` uses the **Stream** parameter to remove the `Zone.Identifier` stream of the file. Finally, the `Get-Item` cmdlet shows that the `Zone.Identifier` stream was deleted.

## Parameters

-Confirm

Prompts you for confirmation before running the cmdlet. For more information, see the following articles:

* [about_Preference_Variables](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables?view=powershell-7.2#confirmpreference)
* [about_Functions_CmdletBindingAttribute](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute?view=powershell-7.2#confirmimpact)

| Type:                       | [SwitchParameter](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.switchparameter) |
| --------------------------- | -------------------------------------------------------------------------------------------------------- |
| Aliases:                    | cf                                                                                                       |
| Position:                   | Named                                                                                                    |
| Default value:              | False                                                                                                    |
| Accept pipeline input:      | False                                                                                                    |
| Accept wildcard characters: | False                                                                                                    |

-Credential

 Note

This parameter is not supported by any providers installed with PowerShell. To impersonate another user, or elevate your credentials when running this cmdlet, use [Invoke-Command](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/invoke-command?view=powershell-7.2).

| Type:                       | [PSCredential](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.pscredential) |
| --------------------------- | -------------------------------------------------------------------------------------------------- |
| Position:                   | Named                                                                                              |
| Default value:              | Current user                                                                                       |
| Accept pipeline input:      | True                                                                                               |
| Accept wildcard characters: | False                                                                                              |

-Exclude

Specifies, as a string array, an item or items that this cmdlet excludes in the operation. The value of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as `*.txt`. Wildcard characters are permitted. The **Exclude** parameter is effective only when the command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character specifies the contents of the `C:\Windows` directory.

When using **Recurse** with  **Exclude** , **Exclude** only filters results of the current directory. If there are files that match the **Exclude** pattern in subfolders, those files are removed along with its parent directory.

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string)[] |
| --------------------------- | ------------------------------------------------------------------ |
| Position:                   | Named                                                              |
| Default value:              | None                                                               |
| Accept pipeline input:      | False                                                              |
| Accept wildcard characters: | True                                                               |

-Filter

Specifies a filter to qualify the **Path** parameter. The [FileSystem](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_filesystem_provider?view=powershell-7.2) provider is the only installed PowerShell provider that supports the use of filters. You can find the syntax for the **FileSystem** filter language in [about_Wildcards](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_wildcards?view=powershell-7.2). Filters are more efficient than other parameters, because the provider applies them when the cmdlet gets the objects rather than having PowerShell filter the objects after they are retrieved.

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string) |
| --------------------------- | ---------------------------------------------------------------- |
| Position:                   | Named                                                            |
| Default value:              | None                                                             |
| Accept pipeline input:      | False                                                            |
| Accept wildcard characters: | True                                                             |

-Force

Forces the cmdlet to remove items that cannot otherwise be changed, such as hidden or read-only files or read-only aliases or variables. The cmdlet cannot remove constant aliases or variables. Implementation varies from provider to provider. For more information, see [about_Providers](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-7.2). Even using the **Force** parameter, the cmdlet cannot override security restrictions.

| Type:                       | [SwitchParameter](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.switchparameter) |
| --------------------------- | -------------------------------------------------------------------------------------------------------- |
| Position:                   | Named                                                                                                    |
| Default value:              | False                                                                                                    |
| Accept pipeline input:      | False                                                                                                    |
| Accept wildcard characters: | False                                                                                                    |

-Include

Specifies, as a string array, an item or items that this cmdlet includes in the operation. The value of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as `"*.txt"`. Wildcard characters are permitted. The **Include** parameter is effective only when the command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character specifies the contents of the `C:\Windows` directory.

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string)[] |
| --------------------------- | ------------------------------------------------------------------ |
| Position:                   | Named                                                              |
| Default value:              | None                                                               |
| Accept pipeline input:      | False                                                              |
| Accept wildcard characters: | True                                                               |

-LiteralPath

Specifies a path to one or more locations. The value of **LiteralPath** is used exactly as it is typed. No characters are interpreted as wildcards. If the path includes escape characters, enclose it in single quotation marks. Single quotation marks tell PowerShell not to interpret any characters as escape sequences.

For more information, see [about_Quoting_Rules](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_quoting_rules?view=powershell-7.2).

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string)[] |
| --------------------------- | ------------------------------------------------------------------ |
| Aliases:                    | PSPath, LP                                                         |
| Position:                   | Named                                                              |
| Default value:              | None                                                               |
| Accept pipeline input:      | True                                                               |
| Accept wildcard characters: | False                                                              |

-Path

Specifies a path of the items being removed. Wildcard characters are permitted.

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string)[] |
| --------------------------- | ------------------------------------------------------------------ |
| Position:                   | 0                                                                  |
| Default value:              | None                                                               |
| Accept pipeline input:      | True                                                               |
| Accept wildcard characters: | True                                                               |

-Recurse

Indicates that this cmdlet deletes the items in the specified locations and in all child items of the locations.

The **Recurse** parameter might not delete all subfolders or all child items. This is a known issue.

 Note

This behavior was fixed in Windows versions 1909 and newer.

| Type:                       | [SwitchParameter](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.switchparameter) |
| --------------------------- | -------------------------------------------------------------------------------------------------------- |
| Position:                   | Named                                                                                                    |
| Default value:              | None                                                                                                     |
| Accept pipeline input:      | False                                                                                                    |
| Accept wildcard characters: | False                                                                                                    |

-Stream

 Note

This Parameter is only available on Windows.

The **Stream** parameter is a dynamic parameter that the FileSystem provider adds to `Remove-Item`. This parameter works only in file system drives.

You can use `Remove-Item` to delete an alternative data stream, such as `Zone.Identifier`. However, it is not the recommended way to eliminate security checks that block files that are downloaded from the Internet. If you verify that a downloaded file is safe, use the `Unblock-File` cmdlet.

This parameter was introduced in Windows PowerShell 3.0. As of Windows PowerShell 7.2, `Remove-Item` can remove alternative data streams from directories as well as files.

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string)[] |
| --------------------------- | ------------------------------------------------------------------ |
| Position:                   | Named                                                              |
| Default value:              | None                                                               |
| Accept pipeline input:      | False                                                              |
| Accept wildcard characters: | True                                                               |

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

**[String](https://docs.microsoft.com/en-us/dotnet/api/system.string)**

You can pipe a string that contains a path, but not a literal path, to this cmdlet.

## Outputs

**None**

This cmdlet does not return any output.

## Notes

The `Remove-Item` cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, type `Get-PsProvider`. For more information, see [about_Providers](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-7.2).

When you try to delete a folder that contains items without using the **Recurse** parameter, the cmdlet prompts for confirmation. Using `-Confirm:$false` does not suppress the prompt. This is by design.

## Related Links

* [Online Version](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.2)
* [Clear-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/clear-item?view=powershell-7.2)
* [Copy-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item?view=powershell-7.2)
* [Get-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-item?view=powershell-7.2)
* [Invoke-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/invoke-item?view=powershell-7.2)
* [Move-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/move-item?view=powershell-7.2)
* [New-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.2)
* [Remove-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-itemproperty?view=powershell-7.2)
* [Rename-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-item?view=powershell-7.2)
* [Set-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-item?view=powershell-7.2)
* [about_Providers](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-7.2)
* [about_Preference_Variables](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables?view=powershell-7.2#confirmpreference)
* [about_Functions_CmdletBindingAttribute](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute?view=powershell-7.2#confirmimpact)
