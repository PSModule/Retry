[CmdletBinding()]
Param(
    # Path to the module to test.
    [Parameter()]
    [string] $Path
)

Write-Verbose "Path to the module: [$Path]" -Verbose

Describe 'Functions' {
    Context 'Invoke-Retry' {
        It 'Invoke-Retry -Count 5 -Delay 5 {...}' {
            {
                Invoke-Retry -Count 5 -Delay 5 {
                    Invoke-RestMethod -Uri 'hhttps://api.myip.com/'
                }
            } | Should -Not -Throw
        }
        It 'Retry {...}' {
            {
                Retry {
                    Invoke-RestMethod -Uri 'hhttps://api.myip.com/'
                }
            } | Should -Not -Throw
        }
        It 'Retry -Count 5 -Delay 5 {...}' {
            {
                Retry -Count 5 -Delay 5 {
                    Invoke-RestMethod -Uri 'hhttps://api.myip.com/'
                }
            } | Should -Not -Throw
        }
    }
}
