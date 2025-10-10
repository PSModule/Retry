function Invoke-Retry {
    <#
        .SYNOPSIS
        Runs a scriptblock with a retry mechanism.

        .DESCRIPTION
        Runs a scriptblock with a retry mechanism.
        If the scriptblock fails, it will retry the scriptblock a number of times with a delay between each try.
        If a catch scriptblock is provided, it will run that scriptblock if the scriptblock fails.

        .EXAMPLE
        ```pwsh
        Retry -Count 5 -Delay 5 -Run {
            Invoke-RestMethod -Uri 'https://api.myip.com/'
        }
        ```

        Retries an API call 5 times with 5 reconds delay.
    #>
    [CmdletBinding()]
    [Alias('Retry')]
    param(
        # The scriptblock to run
        [Parameter(Mandatory)]
        [scriptblock] $Run,

        # The number of tries to make
        [Parameter()]
        [int] $Count = 3,

        # The delay between tries in seconds
        [Parameter()]
        [int] $Delay = 5,

        # A scriptblock to run if it fails
        [Parameter()]
        [scriptblock] $Catch = {},

        # A scriptblock to run after the scriptblock has run
        [Parameter()]
        [scriptblock] $Finally = {}
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
    & $Finally
}
