#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '6.0.0'; MaximumVersion = '6.*'; GUID = 'a699dea5-2c73-4616-a270-1f7abb777e71' }

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
