

$PrinterName = "Printer Name Here"

$PrinterShareName = "\\PrintServerNameHere\SharedPrinterNameHere"

$DriverName = "Canon Generic Plus UFR II"



Remove-Printer -Name "$PrinterName" -ErrorAction SilentlyContinue

Start-Sleep -Seconds 4


Add-PrinterDriver -Name "$DriverName"

Add-Printer -Name "$PrinterShareName" -DriverName "$DriverName" -PortName "$PrinterShareName"

Start-Sleep -Seconds 4


