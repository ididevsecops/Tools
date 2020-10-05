Connect-AzAccount

Select-AzSubscription -Subscription 'sub-dev-idso-000'

$addresses = (Get-AzNetworkServiceTag -Location eastus).Values.Where( { $_.Name -eq 'AzureFrontDoor.Backend' }).Properties.AddressPrefixes

$config = Get-AzResource -ResourceName 'as-webapp-dev-idso-001' -ResourceType Microsoft.Web/sites/config -ResourceGroupName 'rg-webapp-dev-idso-001' -ApiVersion '2019-08-01'

$rules = $config.Properties.ipSecurityRestrictions.Where( { -not ($_.priority -ge 1000 -and $_.priority -le 1999) })

$priority = 1000;

$rules += New-Object PSObject -Property @{
  ipAddress   = '168.63.129.16/32'
  action      = "Allow"
  priority    = $priority
  name        = "Azure Infrastructure $priority"
  description = "Automatically added address"
}
  
$priority++;

$rules += New-Object PSObject -Property @{
  ipAddress   = '169.254.169.254/32'
  action      = "Allow"
  priority    = $priority
  name        = "Azure Infrastructure $priority"
  description = "Automatically added address"
}
  
$priority++;

foreach ($address in $addresses) {
  $rules += New-Object PSObject -Property @{
    ipAddress   = $address
    action      = "Allow"
    priority    = $priority
    name        = "FrontDoor.Backend $priority"
    description = "Automatically added address"
  }
  
  $priority++;
}

$config.Properties.ipSecurityRestrictions = $rules

Set-AzResource -ResourceId $config.ResourceId -Properties $config.Properties -ApiVersion '2019-08-01' -Force
