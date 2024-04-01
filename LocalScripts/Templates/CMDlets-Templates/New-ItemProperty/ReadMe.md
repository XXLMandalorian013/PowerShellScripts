# New-ItemProperty

* Reference

Module:[Microsoft.PowerShell.Management](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/?view=powershell-7.2)

Creates a new property for an item and sets its value.

## Syntax

**PowerShell**Copy

```
New-ItemProperty
   [-Path] <String[]>
   [-Name] <String>
   [-PropertyType <String>]
   [-Value <Object>]
   [-Force]
   [-Filter <String>]
   [-Include <String[]>]
   [-Exclude <String[]>]
   [-Credential <PSCredential>]
   [-WhatIf]
   [-Confirm]
   [<CommonParameters>]
```

**PowerShell**Copy

```
New-ItemProperty
   -LiteralPath <String[]>
   [-Name] <String>
   [-PropertyType <String>]
   [-Value <Object>]
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

The `New-ItemProperty` cmdlet creates a new property for a specified item and sets its value. Typically, this cmdlet is used to create new registry values, because registry values are properties of a registry key item.

This cmdlet does not add properties to an object.

* To add a property to an instance of an object, use the `Add-Member` cmdlet.
* To add a property to all objects of a particular type, modify the Types.ps1xml file.

## Examples

### Example 1: Add a registry entry

This command adds a new registry entry, `NoOfEmployees`, to the `MyCompany` key of the `HKLM:\Software hive`.

The first command uses the **Path** parameter to specify the path of the `MyCompany` registry key. It uses the **Name** parameter to specify a name for the entry and the **Value** parameter to specify its value.

The second command uses the `Get-ItemProperty` cmdlet to see the new registry entry.

**PowerShell**Copy

```
New-ItemProperty -Path "HKLM:\Software\MyCompany" -Name "NoOfEmployees" -Value 822
Get-ItemProperty "HKLM:\Software\MyCompany"

PSPath        : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\software\mycompany
PSParentPath  : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\software
PSChildName   : mycompany
PSDrive       : HKLM
PSProvider    : Microsoft.PowerShell.Core\Registry
NoOfLocations : 2
NoOfEmployees : 822
```

### Example 2: Add a registry entry to a key

This command adds a new registry entry to a registry key. To specify the key, it uses a pipeline operator (`|`) to send an object that represents the key to `New-ItemProperty`.

The first part of the command uses the `Get-Item` cmdlet to get the `MyCompany` registry key. The pipeline operator sends the results of the command to `New-ItemProperty`, which adds the new registry entry (`NoOfLocations`), and its value (`3`), to the `MyCompany` key.

**PowerShell**Copy

```
Get-Item -Path "HKLM:\Software\MyCompany" | New-ItemProperty -Name NoOfLocations -Value 3
```

This command works because the parameter-binding feature of PowerShell associates the path of the **RegistryKey** object that `Get-Item` returns with the **LiteralPath** parameter of `New-ItemProperty`. For more information, see [about_Pipelines](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pipelines?view=powershell-7.2).

### Example 3: Create a MultiString value in the registry using a Here-String

This example creates a `MultiString` value using a Here-String.

**PowerShell**Copy

```
$newValue = New-ItemProperty -Path "HKLM:\SOFTWARE\ContosoCompany\" -Name 'HereString' -PropertyType MultiString -Value @"
This is text which contains newlines
It can also contain "quoted" strings
"@
$newValue.multistring

This is text which contains newlines
It can also contain "quoted" strings
```

### Example 4: Create a MultiString value in the registry using an array

The example shows how to use an array of values to create the `MultiString` value.

**PowerShell**Copy

```
$newValue = New-ItemProperty -Path "HKLM:\SOFTWARE\ContosoCompany\" -Name 'MultiString' -PropertyType MultiString -Value ('a','b','c')
$newValue.multistring[0]

a
```

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

Specifies a user account that has permission to perform this action. The default is the current user.

Type a user name, such as `User01` or `Domain01\User01`, or enter a **PSCredential** object, such as one generated by the `Get-Credential` cmdlet. If you type a user name, you are prompted for a password.

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

Forces the cmdlet to create a property on an object that cannot otherwise be accessed by the user. Implementation varies from provider to provider. For more information, see [about_Providers](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-7.2).

| Type:                       | [SwitchParameter](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.switchparameter) |
| --------------------------- | -------------------------------------------------------------------------------------------------------- |
| Position:                   | Named                                                                                                    |
| Default value:              | False                                                                                                    |
| Accept pipeline input:      | False                                                                                                    |
| Accept wildcard characters: | False                                                                                                    |

-Include

Specifies, as a string array, an item or items that this cmdlet includes in the operation. The value of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as `*.txt`. Wildcard characters are permitted. The **Include** parameter is effective only when the command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character specifies the contents of the `C:\Windows` directory.

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string)[] |
| --------------------------- | ------------------------------------------------------------------ |
| Position:                   | Named                                                              |
| Default value:              | None                                                               |
| Accept pipeline input:      | False                                                              |
| Accept wildcard characters: | True                                                               |

-LiteralPath

Specifies a path to one or more locations. The value of **LiteralPath** is used exactly as it is typed. No characters are interpreted as wildcards. If the path includes escape characters, enclose it in single quotation marks (`'`). Single quotation marks tell PowerShell not to interpret any characters as escape sequences.

For more information, see [about_Quoting_Rules](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_quoting_rules?view=powershell-7.2).

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string)[] |
| --------------------------- | ------------------------------------------------------------------ |
| Aliases:                    | PSPath, LP                                                         |
| Position:                   | Named                                                              |
| Default value:              | None                                                               |
| Accept pipeline input:      | True                                                               |
| Accept wildcard characters: | False                                                              |

-Name

Specifies a name for the new property. If the property is a registry entry, this parameter specifies the name of the entry.

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string) |
| --------------------------- | ---------------------------------------------------------------- |
| Aliases:                    | PSProperty                                                       |
| Position:                   | 1                                                                |
| Default value:              | None                                                             |
| Accept pipeline input:      | True                                                             |
| Accept wildcard characters: | False                                                            |

-Path

Specifies the path of the item. Wildcard characters are permitted. This parameter identifies the item to which this cmdlet adds the new property.

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string)[] |
| --------------------------- | ------------------------------------------------------------------ |
| Position:                   | 0                                                                  |
| Default value:              | None                                                               |
| Accept pipeline input:      | False                                                              |
| Accept wildcard characters: | True                                                               |

-PropertyType

Specifies the type of property that this cmdlet adds. The acceptable values for this parameter are:

* `String`: Specifies a null-terminated string. Used for **REG_SZ** values.
* `ExpandString`: Specifies a null-terminated string that contains unexpanded references to environment variables that are expanded when the value is retrieved. Used for **REG_EXPAND_SZ** values.
* `Binary`: Specifies binary data in any form. Used for **REG_BINARY** values.
* `DWord`: Specifies a 32-bit binary number. Used for **REG_DWORD** values.
* `MultiString`: Specifies an array of null-terminated strings terminated by two null characters. Used for **REG_MULTI_SZ** values.
* `Qword`: Specifies a 64-bit binary number. Used for **REG_QWORD** values.
* `Unknown`: Indicates an unsupported registry data type, such as **REG_RESOURCE_LIST** values.

| Type:                       | [String](https://docs.microsoft.com/en-us/dotnet/api/system.string) |
| --------------------------- | ---------------------------------------------------------------- |
| Aliases:                    | Type                                                             |
| Position:                   | Named                                                            |
| Default value:              | None                                                             |
| Accept pipeline input:      | True                                                             |
| Accept wildcard characters: | False                                                            |

-Value

Specifies the property value. If the property is a registry entry, this parameter specifies the value of the entry.

| Type:                       | [Object](https://docs.microsoft.com/en-us/dotnet/api/system.object) |
| --------------------------- | ---------------------------------------------------------------- |
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

**None**

You cannot pipe input to this cmdlet.

## Outputs

**[PSCustomObject](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.pscustomobject)**

`New-ItemProperty` returns a custom object that contains the new property.

## Notes

`New-ItemProperty` is designed to work with the data exposed by any provider. To list the providers available in your session, type `Get-PSProvider`. For more information, see [about_Providers](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-7.2)

**PowerShell**Copy

```
New-ItemProperty
   [-Path] <String[]>
   [-Name] <String>
   [-PropertyType <String>]
   [-Value <Object>]
   [-Force]
   [-Filter <String>]
   [-Include <String[]>]
   [-Exclude <String[]>]
   [-Credential <PSCredential>]
   [-WhatIf]
   [-Confirm]
   [<CommonParameters>]
```

**PowerShell**Copy

```
New-ItemProperty
   -LiteralPath <String[]>
   [-Name] <String>
   [-PropertyType <String>]
   [-Value <Object>]
   [-Force]
   [-Filter <String>]
   [-Include <String[]>]
   [-Exclude <String[]>]
   [-Credential <PSCredential>]
   [-WhatIf]
   [-Confirm]
   [<CommonParameters>]
```

    Adds a file name extension to a supplied name.

## Related Links

* [OnlineVersion] (https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/New-ItemProperty?view=powershell-7.2&viewFallbackFrom=powershell-3.0)
* [Clear-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/clear-itemproperty?view=powershell-7.2)
* [Copy-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/copy-itemproperty?view=powershell-7.2)
* [Get-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/get-itemproperty?view=powershell-7.2)
* [Move-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/move-itemproperty?view=powershell-7.2)
* [Remove-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/remove-itemproperty?view=powershell-7.2)
* [Rename-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/rename-itemproperty?view=powershell-7.2)
* [Set-ItemProperty](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/set-itemproperty?view=powershell-7.2)
* [about_Providers](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers?view=powershell-7.2)
