Describe "Our Application" {
    #region Azure App Service Endpoint
    Context "When Stopped" -Tag "Offline", "App Service" {
        It "Azure App Service Endpoint Should Not Respond" {
            { Invoke-WebRequest -Uri "https://as-webapp-dev-idso-001.azurewebsites.net" -Method Get } | Should -Throw
        }
    }
    Context "When Started" -Tag "Online", "App Service" {
        It "Azure App Service Endpoint Should Return Status Code 200" {
            (Invoke-WebRequest -Uri "https://as-webapp-dev-idso-001.azurewebsites.net" -Method Get).StatusCode | Should -Be 200
        }
        It "Azure App Service Endpoint Should Return 0 Bytes" {
            (Invoke-WebRequest -Uri "https://as-webapp-dev-idso-001.azurewebsites.net" -Method Get).RawContentLength | Should -Be 0
        }
    }
    #endregion Azure App Service Endpoint

    #region Azure Front Door Endpoint
    Context "When Stopped" -Tag "Offline", "App Service" {
        It "Azure Front Door Should Not Respond" {
            { Invoke-WebRequest -Uri "https://fd-shared-dev-idso-000.azurefd.net" -Method Get } | Should -Throw
        }
    }
    Context "When Started" -Tag "Online", "Front Door" {
        It "Azure Front Door Endpoint Should Return Status Code 200" {
            (Invoke-WebRequest -Uri "https://fd-shared-dev-idso-000.azurefd.net" -Method Get).StatusCode | Should -Be 200
        }
        It "Azure Front Door Endpoint Should Return 0 Bytes" {
            (Invoke-WebRequest -Uri "https://fd-shared-dev-idso-000.azurefd.net" -Method Get).RawContentLength | Should -Be 0
        }
    }
    #endregion Azure Front Door Endpoint

    #region Public Endpoint
    Context "When Stopped" -Tag "Offline" {
        It "Public Endpoint Should Not Respond" {
            { Invoke-WebRequest -Uri "https://api.ididevsecops.net" -Method Get } | Should -Throw
        }
    }
    Context "When Started" -Tag "Online" {
        It "Public Endpoint Should Return Status Code 200" {
            (Invoke-WebRequest -Uri "https://api.ididevsecops.net" -Method Get).StatusCode | Should -Be 200
        }
        It "Public Endpoint Should Endpoint Return 0 Bytes" {
            (Invoke-WebRequest -Uri "https://api.ididevsecops.net" -Method Get).RawContentLength | Should -Be 0
        }
    }
    #endregion Public Endpoint
}
