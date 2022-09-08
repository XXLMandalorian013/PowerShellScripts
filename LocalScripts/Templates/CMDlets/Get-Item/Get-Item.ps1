    #ReadMe
<#
    
NAME
    Get-Item

SYNTAX
    Get-Item [-Path] <string[]> [-Filter <string>] [-Include <string[]>] [-Exclude <string[]>] [-Force]
    [-Credential <pscredential>] [-UseTransaction] [-Stream <string[]>]  [<CommonParameters>]

    Get-Item -LiteralPath <string[]> [-Filter <string>] [-Include <string[]>] [-Exclude <string[]>]
    [-Force] [-Credential <pscredential>] [-UseTransaction] [-Stream <string[]>]  [<CommonParameters>]


PARAMETERS
    -Credential <pscredential>

        Required?                    false
        Position?                    Named
        Accept pipeline input?       true (ByPropertyName)
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false

    -Exclude <string[]>

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false

    -Filter <string>

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false

    -Force

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false

    -Include <string[]>

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false

    -LiteralPath <string[]>

        Required?                    true
        Position?                    Named
        Accept pipeline input?       true (ByPropertyName)
        Parameter set name           LiteralPath
        Aliases                      PSPath
        Dynamic?                     false

    -Path <string[]>

        Required?                    true
        Position?                    0
        Accept pipeline input?       true (ByValue, ByPropertyName)
        Parameter set name           Path
        Aliases                      None
        Dynamic?                     false

    -Stream <string[]>

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     true

    -UseTransaction

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      usetx
        Dynamic?                     false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).


INPUTS
    System.String[]
    System.Management.Automation.PSCredential


OUTPUTS
    System.IO.FileInfo
    System.Boolean
    System.String
    System.IO.FileInfo
    System.IO.DirectoryInfo


ALIASES
    gi


Examples

Example 1: Get the current directory
This example gets the current directory. The dot ('.') represents the item at the current location (not its contents).

PowerShell

Copy
Get-Item .

Directory: C:\

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         7/26/2006  10:01 AM            ps-test

Example 2: Get all the items in the current directory
This example gets all the items in the current directory. The wildcard character (*) represents all the contents of the current item.

PowerShell

Copy
Get-Item *

Directory: C:\ps-test

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         7/26/2006   9:29 AM            Logs
d----         7/26/2006   9:26 AM            Recs
-a---         7/26/2006   9:28 AM         80 date.csv
-a---         7/26/2006  10:01 AM         30 filenoext
-a---         7/26/2006   9:30 AM      11472 process.doc
-a---         7/14/2006  10:47 AM         30 test.txt

Example 3: Get the current directory of a drive
This example gets the current directory of the C: drive. The object that is retrieved represents only the directory, not its contents.

PowerShell

Copy
Get-Item C:
Example 4: Get items in the specified drive
This example gets the items in the C: drive. The wildcard character (*) represents all the items in the container, not just the container.

PowerShell

Copy
Get-Item C:\*
In PowerShell, use a single asterisk (*) to get contents, instead of the traditional *.*. The format is interpreted literally, so *.* wouldn't retrieve directories or filenames without a dot.

Example 5: Get a property in the specified directory
This example gets the LastAccessTime property of the C:\Windows directory. LastAccessTime is just one property of file system directories. To see all the properties of a directory, type (Get-Item <directory-name>) | Get-Member.

PowerShell

Copy
(Get-Item C:\Windows).LastAccessTime

Example 6: Show the contents of a registry key
This example shows the contents of the Microsoft.PowerShell registry key. You can use this cmdlet with the PowerShell Registry provider to get registry keys and subkeys, but you must use the Get-ItemProperty cmdlet to get the registry values and data.

PowerShell

Copy
Get-Item HKLM:\Software\Microsoft\Powershell\1\Shellids\Microsoft.Powershell\

Example 7: Get items in a directory that have an exclusion
This example gets items in the Windows directory with names that include a dot (.), but don't begin with w*.This example works only when the path includes a wildcard character (*) to specify the contents of the item.

PowerShell

Copy
Get-Item C:\Windows\*.* -Exclude "w*"

Example 8: Getting hardlink information
In PowerShell 6.2, an alternate view was added to get hardlink information. To get the hardlink information, pipe the output to Format-Table -View childrenWithHardlink

PowerShell

Copy
Get-Item C:\Windows\System32\ntoskrnl.exe | Format-Table -view childrenWithHardLink

Directory: C:\Windows\System32

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
la---           5/12/2021  7:40 AM       10848576 ntoskrnl.exe
The Mode property identifies the hardlink by the l in la---

Example 9: Output for Non-Windows Operating Systems
In PowerShell 7.1 on Unix systems, the Get-Item cmdlet provides Unix-like output:

PowerShell

Copy
PS> Get-Item /Users

Directory: /

UnixMode    User  Group   LastWriteTime      Size  Name
--------    ----  -----   -------------      ----  ----
drwxr-xr-x  root  admin   12/20/2019 11:46   192   Users
The new properties that are now part of the output are:

UnixMode is the file permissions as represented on a Unix system
User is the file owner
Group is the group owner
Size is the size of the file or directory as represented on a Unix system
 Note

This feature was moved from experimental to mainstream in PowerShell 7.1.

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial
    help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Get-Item -Online" or
           go to https://go.microsoft.com/fwlink/?LinkID=113319.

#>

#Script

