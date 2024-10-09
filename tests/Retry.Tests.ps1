[CmdletBinding()]
Param(
    # Path to the module to test.
    [Parameter()]
    [string] $Path
)

Write-Verbose "Path to the module: [$Path]" -Verbose

Describe 'Functions' {
    Context 'Invoke-Retry' {
        It 'Invoke-Retry -Count 5 -Delay 5 {...} should not throw' {
            {
                Invoke-Retry -Count 5 -Delay 5 {
                    Invoke-RestMethod -Uri 'https://api.myip.com/'
                }
            } | Should -Not -Throw
        }
        It 'Retry {...} should not throw' {
            {
                Retry {
                    Invoke-RestMethod -Uri 'https://api.myip.com/'
                }
            } | Should -Not -Throw
        }
        It 'Retry -Count 5 -Delay 5 {...} should not throw' {
            {
                Retry -Count 5 -Delay 5 {
                    Invoke-RestMethod -Uri 'https://api.myip.com/'
                }
            } | Should -Not -Throw
        }
    }
}
