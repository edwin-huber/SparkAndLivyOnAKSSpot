# create resource group (Optional)
az group create --location $env:DEPLOYMENT_LOCATION --resource-group $env:RESOURCE_GROUP

# create VNET
az network vnet create --resource-group $env:RESOURCE_GROUP -n $env:VNET_NAME --address-prefix 10.0.0.0/8 --subnet-name AzureBastionSubnet --subnet-prefix 10.0.0.0/24

# create the NSGs:

# AKS NSG 
az network nsg create --name aks-subnet-nsg --resource-group $env:RESOURCE_GROUP
# VM NSG
az network nsg create --name vm-subnet-nsg --resource-group $env:RESOURCE_GROUP

# create AKS Subnet
az network vnet subnet create --resource-group $env:RESOURCE_GROUP --vnet-name $env:VNET_NAME --name akssubnet --address-prefixes 10.3.0.0/16 --network-security-group aks-subnet-nsg

# create VM Subnet - Deliberately small
az network vnet subnet create --resource-group $env:RESOURCE_GROUP --vnet-name $env:VNET_NAME --name vmsubnet --address-prefixes 10.2.0.0/29 --network-security-group aks-subnet-nsg
$BastionName = $env:VNET_NAME + "BastionHost"
$PublicIpAddressName= $env:VNET_NAME + "BastionPublicIP"

# create public IP for Bastion
az network public-ip create --name $PublicIpAddressName --resource-group $env:RESOURCE_GROUP --sku Standard
# create Bastion
az network bastion create --location $env:DEPLOYMENT_LOCATION --name $BastionName --public-ip-address $PublicIpAddressName --resource-group $env:RESOURCE_GROUP --vnet-name $env:VNET_NAME