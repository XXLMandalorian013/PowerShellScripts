$ToastPeram = @{

    #Path to a custom pic
    AppLogo = "C:\LOCAL\$env:UserName\My Documents\PowerShell\Modules\BurntToast\1.0.0\Images\friendly neighborhoodPS.png"

    #The header of the notification is enclosed with "" while the body must be enclosed with ''. They both need to be seperated by a ,
    Text = "Local File Backup",'PowerShell Core (7) has started the local file backup.','-DAM'
}

New-BurntToastNotification @ToastPeram