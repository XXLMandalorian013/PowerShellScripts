$WAN = (Invoke-RestMethod -Uri 'http://ipinfo.io/json').ip

Write-Verbose -Message "$WAN" -Verbose
