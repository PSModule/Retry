[CmdletBinding()]
Param(
    # Path to the module to test.
    [Parameter()]
    [string] $Path
)

Write-Verbose "Path to the module: [$Path]" -Verbose

Describe 'Module' {
    Context 'Function: Get-PSModuleTest' {
        It "Invoke-Retry -Count 5 -Delay 5 {...}" {
            { Invoke-Retry -Count 5 -Delay 5 {
                Invoke-RestMethod -Uri 'hhttps://api.myip.com/'
            } | Should -Not -Throw }
        }
        It "Retry 5 5 {...}" {
            { Retry 5 5 {
                Invoke-RestMethod -Uri 'hhttps://api.myip.com/'
            } | Should -Not -Throw }
        }
    }
}
