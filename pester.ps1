Describe "The Application" {
    Context "When Started" -Tag "Online" {
        BeforeAll {
            # TODO - Parameterize after Pester 5.1.0
            $Uri = "https://localhost:443/" # IIS
            # $Uri = "https://localhost:8443/" # Kestrel
            # $Uri = "https://app-mcguffin-prod-idso-000.azurewebsites.net:443/" # App Service East US
            # $Uri = "https://app-mcguffin-prod-idso-001.azurewebsites.net:443/" # App Service North Europe
            # $Uri = "https://fd-shared-prod-idso-000.azurefd.net:443/" # Front Door
            # $Uri = "https://mcguffin.ididevsecops.net:443/" # Public

            $Response = Invoke-WebRequest -Uri $Uri -Method Get -SkipHttpErrorCheck -SkipCertificateCheck

            Write-Host $Response.Headers["idso"] -ForegroundColor Blue
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
    }
}
