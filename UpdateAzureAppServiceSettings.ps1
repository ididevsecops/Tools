# https://msftplayground.com/2016/02/adding-azure-app-service-application-settings-powershell/

Connect-AzAccount

Select-AzSubscription -Subscription "sub-prod-idso-000"

$WebApp = Get-AzWebApp -Name "app-mcguffin-prod-idso-000" -ResourceGroupName "rg-mcguffin-prod-idso-001"

$AppSettings = $WebApp.SiteConfig.AppSettings

$AppSettings.GetType()

$AppSettings

$Settings = @{}

ForEach ($AppSetting in $AppSettings) {
    $Settings[$AppSetting.Name] = $AppSetting.Value
}

$Settings

$Settings["Header"]

$Settings["Header"] = (Get-Date).ToString()

$Settings["Header"]

Set-AzWebApp -Name "app-mcguffin-prod-idso-000" -ResourceGroupName "rg-mcguffin-prod-idso-001" -AppSettings $Settings
