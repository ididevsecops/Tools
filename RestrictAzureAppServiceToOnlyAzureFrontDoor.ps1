# https://www.wintellect.com/restricting-azure-app-service-access-to-azure-front-door/

Connect-AzAccount -TenantId "d3efb988-727d-47ea-adb8-cce6dc17857d" -Subscription "sub-prod-idso-000"

$Addresses = (Get-AzNetworkServiceTag -Location "eastus").Values.Where( { $_.Name -eq "AzureFrontDoor.Backend" }).Properties.AddressPrefixes

$Resource = Get-AzResource -ResourceName "app-mcguffin-prod-idso-000" -ResourceGroupName "rg-mcguffin-prod-idso-001" -ResourceType "Microsoft.Web/sites/config" -ApiVersion "2019-08-01"

$IpSecurityRestrictions = $Resource.Properties.ipSecurityRestrictions.Where( { -not ($_.priority -ge 1000 -and $_.priority -le 1999) })

$Priority = 1000;

$IpSecurityRestrictions += New-Object PSObject -Property @{
  ipAddress   = "168.63.129.16/32"
  action      = "Allow"
  priority    = $Priority
  name        = "Azure Infrastructure $Priority"
  description = "Automatically added address"
}

$Priority++;

$IpSecurityRestrictions += New-Object PSObject -Property @{
  ipAddress   = "169.254.169.254/32"
  action      = "Allow"
  priority    = $Priority
  name        = "Azure Infrastructure $Priority"
  description = "Automatically added address"
}

$Priority++;

foreach ($address in $Addresses) {
  $IpSecurityRestrictions += New-Object PSObject -Property @{
    ipAddress   = $address
    action      = "Allow"
    priority    = $Priority
    name        = "FrontDoor.Backend $Priority"
    description = "Automatically added address"
  }

  $Priority++;
}

$Resource.Properties.ipSecurityRestrictions = $IpSecurityRestrictions

Set-AzResource -ResourceId $Resource.ResourceId -Properties $Resource.Properties -ApiVersion "2019-08-01" -Force
