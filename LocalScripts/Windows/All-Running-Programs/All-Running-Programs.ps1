    #ReadMe
<#

.DESCRIPTION
        
Gets all running programs.  
    

.INPUTS
        
None.


.OUTPUTS
        
System.String,

NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     27    19.08      28.41       0.14   23520   1 ApplicationFrameHost
     61    55.49     129.19       1.25   49740   1 Code
     25    22.66      43.44       5.50   52500   1 CodeSetup-stable-92da9481c0904c6adfe372c12da3b7748d74bdcb.tmp
     63    69.15      94.92      17.73   25632   1 Discord
     77   400.94     187.82       8.55   44744   1 explorer
     49    49.95       2.98       0.00   10088   1 HxOutlook
     45    23.60      41.33      18.55   34652   1 Mitel
    377   379.95     481.90     237.11   21324   1 msedge
     39    21.65      37.36       4.20   19084   1 NVIDIA Share
     69   174.00     214.60      39.25   13116   1 ONENOTE
    164   335.01     451.62       7.39   42708   1 OUTLOOK
    200   486.83     519.40     206.92    9948   1 PhoneExperienceHost
   1683 2,662.55   2,656.01     210.64    3160   1 Revit
    173 1,036.61     744.52   1,325.80   36464   1 Revu
     76   146.03     168.95      40.48   24952   1 Spotify
     58    55.60       3.20       0.09   30508   1 SystemSettings
     51   111.98     151.71      23.33   21084   1 Teams
     81   103.29      94.84       2.73   20992   1 TextInputHost
     48   100.00     100.25       2.89   44964   1 WindowsTerminal



.LINK
        
[Get-Process](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-process?view=powershell-7.3)

[Where-Object](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/where-object?view=powershell-7.3) 


#>

#Script

Get-Process | Where-Object { $_.MainWindowTitle }