#Checks to see if Outlook is installed.

    #https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

    #https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

        $Outlook = "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"


        if(Get-Item -Path $Outlook -ErrorAction Ignore)
        {

            Write-Host "Outlook is installed..."

        }
        else
        {

            Write-Host "Outlook is not installed..."

            Write-Warning "Outlook is not installed...script ending..."

            Start-Sleep -Seconds 6

            Exit

        }


#Checks to see if the Signature folder exists, and creates one if not.

    #https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-item?view=powershell-7.2

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.2


        $User = $env:UserName

        $SigFolderPath = "C:\Users\$User\AppData\Roaming\Microsoft\Signatures"


        if(Get-Item -Path $SigFolderPath -ErrorAction Ignore)
        {

            Write-Host "Signature Folder Exists..."

        }
        else
        {
            Write-Host "Creating Signatures Folder..."

            New-Item -Path C:\Users\$User\AppData\Roaming\Microsoft -Name "Signatures" -ItemType "Folder"

            Start-Sleep -Seconds 3

            Write-Host "Signatures Folder Created..."

            Start-Sleep -Seconds 3

}

#Copys the Signature Template to Outlook

    #https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2

    #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item?view=powershell-7.2


        $SigFolderTemplate = "\\ServerName\Folder\OutlookSigCreate\SignaturesTemplate-4-5-22"


        if(Get-Item -Path $SigFolderTemplate -ErrorAction Ignore)
        {

            Write-Host "Signatures Exists"

        }
        else
        {

            Write-Host "Signatures Imported"

            Copy-Item -Path "$SigFolderTemplate" -Destination "C:\Users\$User\AppData\Roaming\Microsoft\Signatures" -Recurse
        
        }

        