Microsoft Scripting Guy, Ed Wilson, is here. In your script, you are using the **New-ItemProperty** cmdlet to attempt to update a registry key property value. When the registry key property exists, your script works. But when it does not, it fails. Here is a version of your script:

$registryPath = "HKCU:\Software\ScriptingGuys\Scripts"

$Name = "Version"

$value = "1"

New-ItemProperty -Path $registryPath -Name $name -Value $value `

    -PropertyType DWORD -Force | Out-Null

And here is the error message that appears when the registry key does not exist:

[![Image of error message](https://devblogs.microsoft.com/wp-content/uploads/sites/29/2019/02/hsg-4-2-15-01.png "Image of error message")](https://devblogs.microsoft.com/wp-content/uploads/sites/29/2019/02/hsg-4-2-15-01.png)

You need to test for the existence of the registry key. If the registry key does not exist, then you need to create the registry key, and then create the registry key property value. The first thing I like to do is to create the path to the registry key, then specify the property name and the value I want to assign. This consists of three variables as shown here:

$registryPath = "HKCU:\Software\ScriptingGuys\Scripts"

$Name = "Version"

$value = "1"

Now I can use the **Test-Path** cmdlet to see if the registry key exists. To do this, I use the **If** statement, and I look for the registry key that is NOT existing. I use the explanation point (  **! ** ) as the not operator. I need to put the **Test-Path** statement in a pair of parentheses so that I am "NOTing" the condition. This is shown here:

IF(!(Test-Path $registryPath))

You may wonder why I cannot use **Test-Path** to verify that the registry key property does not exist. After all, that is what the script is all about in the first place. The reason, is that **Test-Path** does not know how to work with registry key property values. It will attempt to work, but it does not.

Here is an example of doing that:

PS C:\> Test-Path HKCU:\Software\ScriptingGuys\scripts

True

PS C:\> Test-Path HKCU:\Software\ScriptingGuys\scripts\version

False

PS C:\> (Get-ItemProperty -Path HKCU:\Software\ScriptingGuys\Scripts -Name version).version

1

PS C:\> Test-Path HKCU:\Software\ScriptingGuys\scripts\version -PathType Leaf

False

PS C:\> Test-Path HKCU:\Software\ScriptingGuys\scripts\version -PathType Any

False

After I verify that the registry key exists, I use the **New-ItemProperty** cmdlet to create or update my registry key property value:

New-Item -Path $registryPath -Force | Out-Null

    New-ItemProperty -Path$registryPath -Name $name -Value $value `

    -PropertyType DWORD -Force | Out-Null

If the registry key already exists, there is no need to attempt to create it again, so I create the registry key property value. As shown here, this code appears in the **ELSE** condition of the statement:

ELSE {

    New-ItemProperty -Path$registryPath -Name $name -Value $value `

    -PropertyType DWORD -Force | Out-Null}

Here is the complete script:

$registryPath = "HKCU:\Software\ScriptingGuys\Scripts"

$Name = "Version"

$value = "1"

IF(!(Test-Path $registryPath))

  {

    New-Item -Path $registryPath -Force | Out-Null

    New-ItemProperty -Path$registryPath -Name $name -Value $value `

    -PropertyType DWORD -Force | Out-Null}

 ELSE {

    New-ItemProperty -Path$registryPath -Name $name -Value $value `

    -PropertyType DWORD -Force | Out-Null}

I can use the **Registry Editor** to verify that my registry key property value exists with the proper value:

[![Image of menu](https://devblogs.microsoft.com/wp-content/uploads/sites/29/2019/02/hsg-4-2-15-02.png "Image of menu")](https://devblogs.microsoft.com/wp-content/uploads/sites/29/2019/02/hsg-4-2-15-02.png)

Or, I can use the Get-ItemProperty cmdlet. Such a command is shown here:

PS C:\> (Get-ItemProperty -Path HKCU:\Software\ScriptingGuys\Scripts -Name version).version

1

I could use **Get-ItemProperty** to verify if a registry key property value exists. If the registry key property does not exist, the error message is very specific. It is shown here:

PS C:\> (Get-ItemProperty -Path HKCU:\Software\ScriptingGuys\Scripts -Name version).version

Get-ItemProperty : Property version does not exist at path HKEY_CURRENT_USER\Software\ScriptingGuys\Scripts.

At line:1 char:2

+ (Get-ItemProperty -Path HKCU:\Software\ScriptingGuys\Scripts -Name version).vers …
+ ```

   + CategoryInfo          : InvalidArgument: (version:String) [Get-ItemProperty], PSArgumentException

   + FullyQualifiedErrorId : System.Management.Automation.PSArgumentException,Microsoft.PowerShell.Commands.GetItemPropertyCommand

  ```

If the registry key itself does not exist, I get a different error message. This is shown here:

PS C:\> (Get-ItemProperty -Path HKCU:\Software\ScriptingGuys\Scripts -Name version).version

Get-ItemProperty : Cannot find path 'HKCU:\Software\ScriptingGuys\Scripts' because it does not exist.

At line:1 char:2

+ (Get-ItemProperty -Path HKCU:\Software\ScriptingGuys\Scripts -Name version).vers …
+ ```

   + CategoryInfo          : ObjectNotFound: (HKCU:\Software\ScriptingGuys\Scripts:String) [Get-ItemProperty],

   ItemNotFoundException

   + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetItemPropertyCommand

  ```

The first error message complains about the PROPERTY, the second error complains about the PATH. So, two different error messages are returned depending on the issue. Therefore, I could implement structured error handling, detect the specific error, and then correct it as appropriate.

But that would be more complicated than I want to do for making simple registry changes. If you have such a need, you may want to check out this collection of [Hey, Scripting Guy! Blog posts](https://social.technet.microsoft.com/Search/en-US?query=structured%20error%20handling&rn=Hey,%20Scripting%20Guy!%20Blog&rq=site:blogs.technet.com/b/heyscriptingguy/&beta=0&ac=5), where I talk about structured error handling in Windows PowerShell scripts.

DC, that is all that is needed to fix your registry script. Troubleshooting Week will continue tomorrow when I will talk about more cool stuff.

# Related Links

* [OnlineVersion] (https://devblogs.microsoft.com/scripting/update-or-add-registry-key-value-with-powershell/https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Management/New-ItemProperty?view=powershell-7.2&viewFallbackFrom=powershell-3.)
