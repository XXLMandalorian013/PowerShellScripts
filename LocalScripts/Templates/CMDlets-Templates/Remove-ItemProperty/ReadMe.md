# Remove-ItemProperty

* Reference

Module:[Microsoft.PowerShell.Management](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/?view=powershell-7.2)

Deletes the property and its value from an item.

## Syntax

**PowerShell**Copy

```
Remove-ItemProperty
      [-Path] <String[]>
      [-Name] <String[]>
      [-Force]
      [-Filter <String>]
      [-Include <String[]>]
      [-Exclude <String[]>]
      [-Credential <PSCredential>]
      [-InformationAction <ActionPreference>]
      [-InformationVariable <String>]
      [-WhatIf]
      [-Confirm]
      [<CommonParameters>]
```

**PowerShell**Copy

```
Remove-ItemProperty
      -LiteralPath <String[]>
      [-Name] <String[]>
      [-Force]
      [-Filter <String>]
      [-Include <String[]>]
      [-Exclude <String[]>]
      [-Credential <PSCredential>]
      [-WhatIf]
      [-Confirm]
      [<CommonParameters>]
```

## Description

The `Remove-ItemProperty` cmdlet deletes a property and its value from an item. You can use it to delete registry values and the data that they store.

## Examples

### Example 1: Delete a registry value

This command deletes the "SmpProperty" registry value, and its data, from the "SmpApplication" subkey of the `HKEY_LOCAL_MACHINE\Software` registry key.

**PowerShell**Copy

```
Remove-ItemProperty -Path "HKLM:\Software\SmpApplication" -Name "SmpProperty"
```

Because the command is issued from a file system drive (`PS C:\>`), it includes the fully qualified path of the "SmpApplication" subkey, including the drive, `HKLM:`, and the "Software" key.

### Example 2: Delete a registry value from the HKCU location

These commands delete the "Options" registry value, and its data, from the "MyApp" subkey of "HKEY_CURRENT_USER\Software\MyCompany".

**PowerShell**Copy

```
PS C:\> Set-Location HKCU:\Software\MyCompany\MyApp
PS HKCU:\Software\MyCompany\MyApp> Remove-ItemProperty -Path . -Name "Options" -Confirm
```

The first command uses the `Set-Location` cmdlet to change the current location to the **HKEY_CURRENT_USER** drive (`HKCU:`) and the `Software\MyCompany\MyApp` subkey.

The second command uses `Remove-ItemProperty` to remove the "Options" registry value, and its data, from the "MyApp" subkey. Because **Path** is required, the command uses a dot (`.`) to indicate the current location. The **Confirm** parameter requests a user prompt before deleting the value.

### Example 3: Remove a registry value by using the pipeline

This command deletes the "NoOfEmployees" registry value, and its data, from the `HKLM\Software\MyCompany` registry key.

**PowerShell**Copy

```
Get-Item -Path HKLM:\Software\MyCompany | Remove-ItemProperty -Name NoOfEmployees
```

The command uses the `Get-Item` cmdlet to get an item that represents the registry key. It uses a pipeline operator (`|`) to send the object to `Remove-ItemProperty`. Then, it uses the **Name** parameter of `Remove-ItemProperty` to specify the name of the registry value.

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

This parameter is not supported by any providers installed with PowerShell. To impersonate another user, or elevate your credentials when running this cmdlet, use [Invoke-Command](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/invoke-command?view=powershell-7.2).

| Type:                       | [PSCredential](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.pscredential) |
| --------------------------- | -------------------------------------------------------------------------------------------------- |
| Position:                   | Named                                                                                              |
| Default value:              | Current user                                                                                       |
| Accept pipeline input:      | True                                                                                               |
| Accept wildcard characters: | False                                                                                              |

-Exclude

Specifies, as a string array, an item or items that this cmdlet excludes in the operation. The value of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as `*.txt`. Wildcard characters are permitted. The **Exclude** parameter is effective only when the command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character specifies the contents of the `C:\Windows` directory.

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

Forces the cmdlet to remove a property of an object that cannot otherwise be accessed by the user. Implementation varies from provider to provider. For more information, see [about_Providers](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-7.2).

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

-Name

Specifies the names of the properties to remove. Wildcard characters are permitted.

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string)[] |
| --------------------------- | ------------------------------------------------------------------ |
| Aliases:                    | PSProperty                                                         |
| Position:                   | 1                                                                  |
| Default value:              | None                                                               |
| Accept pipeline input:      | True                                                               |
| Accept wildcard characters: | True                                                               |

-Path

Specifies the path of the item whose properties are being removed. Wildcard characters are permitted.

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string)[] |
| --------------------------- | ------------------------------------------------------------------ |
| Position:                   | 0                                                                  |
| Default value:              | None                                                               |
| Accept pipeline input:      | True                                                               |
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

* In the PowerShell Registry provider, registry values are considered to be properties of a registry key or subkey. You can use the **ItemProperty** cmdlets to manage these values.
* `Remove-ItemProperty` is designed to work with the data exposed by any provider. To list the providers available in your session, type `Get-PSProvider`. For more information, see [about_Providers](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-7.2).

## Related Links

* [Oneline Version](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-itemproperty?view=powershell-7.2)
* [Get-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-item?view=powershell-7.2)
* [Clear-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/clear-itemproperty?view=powershell-7.2)
* [Copy-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-itemproperty?view=powershell-7.2)
* [Get-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-itemproperty?view=powershell-7.2)
* [Move-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/move-itemproperty?view=powershell-7.2)
* [New-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-itemproperty?view=powershell-7.2)
* [Remove-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.2)
* [Rename-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-itemproperty?view=powershell-7.2)
* [Set-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-itemproperty?view=powershell-7.2)
* [Set-Location](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-location?view=powershell-7.2)
* [about_Providers](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-7.2)
