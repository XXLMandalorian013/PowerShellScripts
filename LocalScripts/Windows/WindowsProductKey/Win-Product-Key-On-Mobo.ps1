#Gets the Product key if its baked into the mobo. If nothing is returned than look for a sticker on the side of the case.
    (Get-CimInstance -ClassName SoftwareLicensingService).OA3xOriginalProductKey 
