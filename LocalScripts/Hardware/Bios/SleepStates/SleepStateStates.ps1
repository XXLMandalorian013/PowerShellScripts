#Reports the sleep states available on the computer & reasons why sleep states are unavailable.

#https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/tools-available

        Write-Host "
        
                S0 – System is fully powered on,
        
                S1 – Power on Suspend(POS): Power to the CPU and RAM is maintained,
        
                S2 – CPU powered off,

                S3 – Standby, Sleep or Suspend: RAM still has power,

                S4 – Hibernation: Memory is saved to the hard drive and the system is powered down,

                S5 – Shut Down: The power supply still supplies power to the power button.
        
        "

        Powercfg /a