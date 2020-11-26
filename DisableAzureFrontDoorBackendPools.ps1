# https://www.powershellbros.com/how-to-disable-azure-front-door-node/

Connect-AzAccount -TenantId "d3efb988-727d-47ea-adb8-cce6dc17857d" -Subscription "sub-prod-idso-000"

$FrontDoor = Get-AzFrontDoor -Name "fd-shared-prod-idso-000" -ResourceGroupName "rg-shared-prod-idso-000"

$FrontDoor.BackendPools.Backends.Where({$_.Address -eq "app-mcguffin-prod-idso-000.azurewebsites.net"})[0].Weight = 1
$FrontDoor.BackendPools.Backends.Where({$_.Address -eq "app-mcguffin-prod-idso-001.azurewebsites.net"})[0].Weight = 100

Set-AzFrontDoor -InputObject $FrontDoor

# or

$FrontDoor.BackendPools.Backends.Where({$_.Address -eq "app-mcguffin-prod-idso-000.azurewebsites.net"})[0].EnabledState = "Disabled"
$FrontDoor.BackendPools.Backends.Where({$_.Address -eq "app-mcguffin-prod-idso-001.azurewebsites.net"})[0].EnabledState = "Enabled"

Set-AzFrontDoor -InputObject $FrontDoor
