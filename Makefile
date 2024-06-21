# Makefile
include config.env
export $(shell sed 's/=.*//' config.env)

login:
	@az login --tenant "$(TENANT_ID)" && az account set --subscription "$(SUBSCRIPTION_ID)"

setup:
	@echo "Creating resource group..."
	@az group create \
		--name "$(RESOURCE_GROUP)" \
		--location "$(LOCATION)"
	@echo "Creating VM..."
	@az vm create \
    	--resource-group "$(RESOURCE_GROUP)" \
    	--size "$(VM_SIZE)" \
    	--name "$(VM_NAME)" \
    	--image canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2:latest \
    	--location "$(LOCATION)" \
    	--public-ip-address-dns-name "$(VM_NAME)" \
    	--admin-username "$(USER_NAME)" \
    	--ssh-key-values "$(SSH_KEY)" \
    	--os-disk-size-gb "$(OS_DISK_SIZE_IN_GB)"

stop:
	@echo "Stopping VM..."
	@az vm stop \
		--name $(VM_NAME) \
		--resource-group $(RESOURCE_GROUP)

start:
	@echo "Starting VM..."
	@az vm start \
		--name $(VM_NAME) \
		--resource-group $(RESOURCE_GROUP)

ssh:
	eval "ssh -i $(SSH_PRIV_KEY) $(USER_NAME)@$(VM_NAME).$(LOCATION).cloudapp.azure.com"

destroy:
	@az group delete \
		--name "$(RESOURCE_GROUP)" \
		--yes

set-autoshutdown:
	@az vm auto-shutdown \
		--resource-group "$(RESOURCE_GROUP)" \
		--name "$(VM_NAME)" \
		--time "$(VM_AUTO_SHUTDOWN_TIME)"

