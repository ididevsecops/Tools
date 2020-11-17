Describe "The Application" {
    Context "When Started" -Tag "Online" {
        BeforeAll {
            # IIS (Development)
            $Uri = "http://localhost:80/" 
            # $Uri = "https://localhost:443/"

            # Kestrel (Development)
            # $Uri = "http://localhost:8080/"
            # $Uri = "https://localhost:8443/"

            # Azure App Service (East US)
            # $Uri = "http://app-mcguffin-prod-idso-000.azurewebsites.net:80/"
            # $Uri = "https://app-mcguffin-prod-idso-000.azurewebsites.net:443/"

            # Azure App Service (North Europe)
            # $Uri = "http://app-mcguffin-prod-idso-001.azurewebsites.net/"
            # $Uri = "https://app-mcguffin-prod-idso-001.azurewebsites.net:443/"

            # Azure Front Door
            # $Uri = "http://fd-shared-prod-idso-000.azurefd.net:80/"
            # $Uri = "https://fd-shared-prod-idso-000.azurefd.net:443/"

            # Azure Virtual Machine (vmmcguffin000, pipvmmcguffin000prodidso000.eastus.cloudapp.azure.com)
            # $Uri = "http://104.45.196.133:80/"
            # $Uri = "https://104.45.196.133:443/"

            # Azure Virtual Machine (vmmcguffin000, pipvmmcguffin000prodidso000.eastus.cloudapp.azure.com)
            # $Uri = "http://pipvmmcguffin000prodidso000.eastus.cloudapp.azure.com:80/"
            # $Uri = "https://pipvmmcguffin000prodidso000.eastus.cloudapp.azure.com:443/"
            
            # Azure Load Balancer for Virtual Machine(s) (vmmcguffin*)
            # $Uri = "http://23.96.110.193:80/"
            # $Uri = "https://23.96.110.193:443/"

            # Azure Load Balancer for Virtual Machine(s) (vmmcguffin*)
            # $Uri = "http://pipvmmcguffinprodidso000.eastus.cloudapp.azure.com:80/"
            # $Uri = "https://pipvmmcguffinprodidso000.eastus.cloudapp.azure.com:443/"

            # $Uri = "http://mcguffin.ididevsecops.net:80/" # Public Domain
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
