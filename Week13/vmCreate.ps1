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

# Create a network interface and associate the public IP address
$nic = New-AzNetworkInterface -Name 'MyNic' -ResourceGroupName $resourceGroupName -Location $location -SubnetId $virtualNetwork.Subnets[0].Id -PublicIpAddressId $publicIP.Id

# Create a new network security group
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Location $location -Name 'MyNSG'

# Create a new inbound security rule to allow RDP access (port 3389)
$rdpRule = New-AzNetworkSecurityRuleConfig -Name 'Allow-RDP' `
    -Access Allow -Protocol Tcp -Direction Inbound -Priority 1000 -SourceAddressPrefix '*' `
    -SourcePortRange '*' -DestinationAddressPrefix '*' -DestinationPortRange 3389

# Add the RDP rule to the NSG
$nsg.SecurityRules.Add($rdpRule)

# Update the NSG with the RDP rule
Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsg

# Associate the NSG with the network interface
$nic.NetworkSecurityGroup = $nsg
Set-AzNetworkInterface -NetworkInterface $nic


# Secure password for the VM
$securePassword = ConvertTo-SecureString 'Test1234$$$$' -AsPlainText -Force

# VM credentials
$credential = New-Object System.Management.Automation.PSCredential ('azureuser', $securePassword)

# Configure the VM
$vmConfig = New-AzVMConfig -VMName 'MyVM' -VMSize 'Standard_D2s_v3' |
 Set-AzVMOperatingSystem -Windows -ComputerName 'MyVM' -Credential $credential -ProvisionVMAgent -EnableAutoUpdate |
 Set-AzVMSourceImage -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus '2016-Datacenter' -Version 'latest' |
 Add-AzVMNetworkInterface -Id $nic.Id |
 Set-AzVMOSDisk -CreateOption FromImage -Caching ReadWrite -StorageAccountType StandardSSD_LRS

 # Create the VM
New-AzVM -ResourceGroupName $resourceGroupName -Location $location -VM $vmConfig