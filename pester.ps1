Describe "The Application" {
    Context "When Started" -Tag "Online" {
        BeforeAll {
            function GetUri () { "http://app.ididevsecops.net" }
            function GetHeader() { "WebApp1" }
            function InvokeUri () { Invoke-WebRequest -Uri $(GetUri) -Method Get -SkipHttpErrorCheck -SkipCertificateCheck }
        }
        It "Should Respond" {
            $Response = $(InvokeUri)
            $Response.StatusCode | Should -Be 200
            $Response.RawContentLength | Should -Be 0
            $Response.Headers["idso"] | Should -Not -BeNullOrEmpty
            $Response.Headers["idso"] | Should -Be $(GetHeader)
        }
    }
}
