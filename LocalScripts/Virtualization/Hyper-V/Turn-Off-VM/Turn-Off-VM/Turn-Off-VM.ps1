$Global:VMName = "Win10VM-Test-4"

Stop-VM -VMName "$Global:VMName" -TurnOff -Confirm
