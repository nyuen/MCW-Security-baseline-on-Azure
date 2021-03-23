az vm image terms accept --urn microsoft-ads:windows-data-science-vm:windows2016byol:latest

az deployment group create -g MyResourceGroup --template-file template.json \
    --parameters "{ \"sqlservername\": { \"value\": \"azsecurity-ny-b8a5fef0\" }, \"userObjectId\": { \"value\" : \"xxx-xxx-xxx-xxxx\"} }"

#create network security group rules for DB subnet
az network nsg rule create --name Port_1433 --nsg-name DbTrafficOnly --priority 100 --resource-group MCW-Security-RG --source-address-prefixes 10.1.0.4 --destination-port-ranges 1433 
az network nsg rule create --name Port_3389 --nsg-name DbTrafficOnly --priority 101 --resource-group MCW-Security-RG --source-address-prefixes 10.0.0.4 --destination-port-ranges 3389 
az network nsg rule create --name Port_1433_Paw --nsg-name DbTrafficOnly --priority 102 --resource-group MCW-Security-RG --source-address-prefixes 10.0.0.4 --destination-port-ranges 1433 

#create network security group rules for web subnet
az network nsg rule create --name Port_80_443 --nsg-name WebTrafficOnly --priority 100 --resource-group MCW-Security-RG --source-address-prefixes "*" --destination-port-ranges 80 443 
az network nsg rule create --name Port_3389 --nsg-name WebTrafficOnly --priority 101 --resource-group MCW-Security-RG --source-address-prefixes 10.0.0.4 --destination-port-ranges 3389 

az network nsg rule create --name Port_8172 --nsg-name WebTrafficOnly --priority 200 --resource-group MCW-Security-RG --source-address-prefixes 10.0.0.4 --destination-port-ranges 8172 
