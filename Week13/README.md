
# Azure Virtual Network Automation Script

This PowerShell script automates the creation of Azure resources such as resource groups, virtual networks, and subnets. It's designed for users who want to streamline the setup of a basic networking infrastructure in Azure.

## Features

- **Resource Group Creation**: Automatically creates a new Azure resource group in the specified location.
- **Virtual Network Configuration**: Creates a virtual network with a custom address space.
- **Subnet Creation**: Adds a subnet configuration to the virtual network.

## Prerequisites

Before using this script, ensure you have the following:

1. **Azure PowerShell Module**: Installed and updated. Use the following command to install it:
    ```powershell
    Install-Module -Name Az -AllowClobber -Scope CurrentUser
    ```

2. **Azure Account Access**: Logged in to your Azure account. Use the following command to log in:
    ```powershell
    Connect-AzAccount
    ```

## Usage

1. **Edit the Script**: Open the script file and modify the following variables to suit your environment:
    - `$resourceGroupName`: The name of the resource group to be created.
    - `$location`: The Azure region where the resources will be deployed (e.g., `East US`).
    - `$virtualNetworkName`: Name of the virtual network.
    - `$addressPrefix`: Address space for the virtual network.
    - `$subnetName`: Name of the subnet.
    - `$subnetPrefix`: Address range for the subnet.

2. **Run the Script**: Execute the script in PowerShell:
    ```powershell
    .mPowerShell.ps1
    ```

3. **Verify Resources**: Once the script completes, verify the resources in the Azure portal or using Azure CLI.

## Example Configuration

The default configuration creates:
- A resource group named `MyResourceGroup` in the `East US` region.
- A virtual network named `MyVnet` with an address space of `10.0.0.0/16`.
- A subnet named `MySubnet` with an address range of `10.0.0.0/24`.

## Customization

You can extend the script to include additional resources such as:
- Virtual machines
- Network security groups
- Public IP addresses

Refer to the [Azure PowerShell Documentation](https://learn.microsoft.com/en-us/powershell/azure/) for more details.

## Troubleshooting

- **Module Not Found**: Ensure the Az module is installed and imported correctly.
- **Insufficient Permissions**: Verify your Azure account has the necessary permissions to create resources.
- **Invalid Parameters**: Check that all parameters (e.g., location, address space) are valid.

## License

This script is provided "as-is" under the MIT License. See the LICENSE file for more details.

---

Happy automating with Azure! 🎉
# make read me

