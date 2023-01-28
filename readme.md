# Azure Key Vault App Config Demo

This demo shows how to use Azure Keyvault secrets to set application configuration settings


## Following the Demo

1. Build the docker image locally to run
2. Push the docker image out to a docker hub
3. Update main.tf file kv-name var with a unique keyvault name
3. Update main.tf file with the docker image name
4. Update main.tf file with the web app name (needs to be unique)
5. Run az login at the terminal to authenticate to Azure
6. terraform init in the ./terraform directory
7. terraform apply in the ./terraform directory
8. Go and add a secret to the keyvault that was created (through Azure portal)
9. Update the application configuration key name in the app service to CONFIG_VALUE_SAMPLE
10. Update the application configuration value in the app service to the name of your secret
11. Call the endpoint {your website}/config_value to see the value
12. Change the secret value
13. run commands below to add fake app settings
14. Call the endpoint {your website}/config_value to see the new value


## Forcing a fake app setting to reload Keyvault based configurations

echo "current settings---"
az webapp config appsettings list --name ase-app-config-test --resource-group rg-web-app
echo "create temp setting---"
az webapp config appsettings set  --name ase-app-config-test --resource-group rg-web-app --settings my_temp_setting=ThisMakesTotalSense
echo "delete temp setting---"
az webapp config appsettings delete  --name ase-app-config-test --resource-group rg-web-app --setting-names my_temp_setting 