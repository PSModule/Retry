function Invoke-Retry {
    <#
        .SYNOPSIS
        Runs a scriptblock with a retry mechanism.

        .EXAMPLE
        Retry -Count 5 -Delay 5 -Run {
            Invoke-RestMethod -Uri 'https://api.myip.com/'
        }
    #>
    [CmdletBinding()]
    [Alias('Retry')]
    param(
        # The number of tries to make
        [int] $Count = 3,

        # The delay between tries in seconds
        [int]$Delay = 5,

        # The scriptblock to run
        [scriptblock] $Run,

        # A scriptblock to run if it fails
        [scriptblock]$Catch = {}
    )

    $ErrorActionPreference = 'Stop'

    for ($i = 0; $i -lt $Count; $i++) {
        try {
            & $Run
            break
        } catch {
            Write-Warning "The command:"
            Write-Warning $Run.ToString()
            Write-Warning "failed with error: $_"
            & $Catch
            if ($i -eq $Count - 1) {
                throw
            }

            Write-Warning "Retrying in $Delay seconds..."
            Start-Sleep -Seconds $Delay
        }
    }
}