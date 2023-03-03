    #ReadMe
<#

.DESCRIPTION
        
Gets all running Programs.  
    

.INPUTS
        
None.


.OUTPUTS
        
System.String,

PS C:\Users\XXX> Get-Process | Where-Object MainWindowTitle

 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     28    19.11      28.43       0.14   23520   1 ApplicationFrameHost
     59    62.36     138.49      30.84   49740   1 Code
     24    22.41      43.47       5.50   52500   1 CodeSetup-stable-92da9481c0904c6adfe372c12da3b7748d74bdcb.tmp
     61    67.13      98.75      37.92   25632   1 Discord
     79   401.32     190.31      10.05   44744   1 explorer
     34    47.96      99.55       3.19   37864   1 GitHubDesktop
     49    49.95       2.98       0.00   10088   1 HxOutlook
     45    23.77      42.05      24.48   34652   1 Mitel
    444   399.05     506.44     306.00   21324   1 msedge
     39    21.65      37.41       5.36   19084   1 NVIDIA Share
     67   174.52     216.83      40.33   13116   1 ONENOTE
    165   342.45     464.21      17.39   42708   1 OUTLOOK
    202   491.62     543.51     253.11    9948   1 PhoneExperienceHost
    175 1,086.05     789.89   1,477.30   36464   1 Revu
     76   156.87     181.80      53.95   24952   1 Spotify
     58    55.60       3.20       0.09   30508   1 SystemSettings
     52   109.18     149.45      25.34   21084   1 Teams
     87   123.50     147.96       4.25   20992   1 TextInputHost
     49   104.62     107.84      26.05   44964   1 WindowsTerminal

.LINK

       
[Get-Process](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-process?view=powershell-7.3)

[Where-Object](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/where-object?view=powershell-7.3)


#>

#Script

Get-Process | Where-Object MainWindowTitle