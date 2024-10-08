[CmdletBinding()]
Param(
    # Path to the module to test.
    [Parameter()]
    [string] $Path
)

Write-Verbose "Path to the module: [$Path]" -Verbose

Describe 'Module' {
    It 'Function: Get-PSModuleTest' {
        { Retry -Count 5 -Delay 5 {
            Invoke-RestMethod -Uri 'hhttps://api.myip.com/'
        } | Should -Not -Throw }
    }
}
