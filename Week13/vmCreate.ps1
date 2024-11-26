$resourceGroupName = 'MyResourceGroup'
$location = 'East US'

# Create a new resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create a new virtual network
$virtualNetwork = New-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Location $location -Name 'MyVnet' -AddressPrefix '10.0.0.0/16'

# Add a subnet configuration to the virtual network
$subnetConfig = Add-AzVirtualNetworkSubnetConfig -Name 'MySubnet' -AddressPrefix '10.0.0.0/24' -VirtualNetwork $virtualNetwork

# Set the virtual network with the new subnet configuration
$virtualNetwork = Set-AzVirtualNetwork -VirtualNetwork $virtualNetwork

# Create a public IP address with Static allocation (Standard SKU requires Static)
$publicIP = New-AzPublicIpAddress -Name 'MyPublicIP' -ResourceGroupName $resourceGroupName -Location $location -AllocationMethod Static -Sku Standard