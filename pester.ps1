Describe "Our Application" {
    Context "When Stopped" -Tag "Offline" {
        It "Should Not Respond" {
            { Invoke-WebRequest -Uri "https://fd-shared-dev-idso-000.azurefd.net" -Method Get } | Should -Throw
        }
    }
    Context "When Started" -Tag "Online" {
        It "Should Return Status Code 200" {
            (Invoke-WebRequest -Uri "https://fd-shared-dev-idso-000.azurefd.net" -Method Get).StatusCode | Should -Be 200
        }
        It "Should Return 0 Bytes" {
            (Invoke-WebRequest -Uri "https://fd-shared-dev-idso-000.azurefd.net" -Method Get).RawContentLength | Should -Be 0
        }
    }
}
