$resourceGroupName = 'MyResourceGroup'
$location = 'East US'

# Create a new resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create a new virtual network
$virtualNetwork = New-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Location $location -Name 'MyVnet' -AddressPrefix '10.0.0.0/16'