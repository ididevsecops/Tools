Describe "The Application" {
    Context "When Started" -Tag "Online" {
        BeforeAll {
            # $Uri = "https://localhost:443/" # IIS (Development)
            # $Uri = "https://localhost:8443/" # Kestrel (Development)
            # $Uri = "https://app-mcguffin-prod-idso-000.azurewebsites.net:443/" # Azure App Service (East US)
            # $Uri = "https://app-mcguffin-prod-idso-001.azurewebsites.net:443/" # Azure App Service (North Europe)
            $Uri = "https://fd-shared-prod-idso-000.azurefd.net:443/" # Azure Front Door
            # $Uri = "https://mcguffin.ididevsecops.net:443/" # Public Domain

            $Response = Invoke-WebRequest -Uri $Uri -Method Get -SkipHttpErrorCheck -SkipCertificateCheck
        }
        It "Should Return 200" {
            $Response.StatusCode | Should -Be 200
        }
        It "Should Return 0 Bytes" {
            $Response.RawContentLength | Should -Be 0
        }
        It "Should Return Header" {
            $Response.Headers["idso"] | Should -Not -BeNullOrEmpty
        }
        AfterAll {
            Write-Host $Response.Headers["idso"] -ForegroundColor DarkYellow
        }
    }
}
