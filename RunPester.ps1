param(
    [switch]
    $Loop = $false
)

$ProgressPreference = "SilentlyContinue"

Clear-Host

do {
    Invoke-Pester -Path .\pester.ps1 -Output Detailed

    Start-Sleep -Seconds 1
}
while ($Loop)
