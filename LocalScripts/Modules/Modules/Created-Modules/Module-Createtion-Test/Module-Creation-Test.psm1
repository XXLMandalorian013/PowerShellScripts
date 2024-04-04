function Show-Calendar {
    param(
        [DateTime] $start = [DateTime]::Today,
        [DateTime] $end = $start,
        $firstDayOfWeek,
        [int[]] $highlightDay,
        [string[]] $highlightDate = [DateTime]::Today.ToString('yyyy-MM-dd')
        )
    
    #actual code for the function goes here see the end of the topic for the complete code sample
    }
    Export-ModuleMember -Function Show-Calendar