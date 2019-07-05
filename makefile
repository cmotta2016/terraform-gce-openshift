create_base_image:	
	@[ "${rhn_username}" ] || ( echo ">> rhn_username is not set"; exit 1 )
	@[ "${rhn_password}" ] || ( echo ">> rhn_password is not set"; exit 1 )
	# Creating network environment (network, subnetwork, firewall rules and ssh-key
	terraform apply -auto-approve -target module.network -target google_compute_project_metadata_item.ssh-key
	# Creating temporary rhel image
	terraform apply -auto-approve -target module.create_temp_image -var 'rhn_username=${rhn_username}' -var 'rhn_password=${rhn_password}'
	# Creating rhel base image
	terraform apply -auto-approve -target module.create_base_image
	# Removing temporary instance, temporary image, temporary tar file and temporary bucket
	terraform destroy -auto-approve -target module.create_temp_image

bastion_node:
	# Creating Bastion Node
	@[ "${rhn_username}" ] || ( echo ">> rhn_username is not set"; exit 1 )
	@[ "${rhn_password}" ] || ( echo ">> rhn_password is not set"; exit 1 )
	@[ "${pool_id}" ] || ( echo ">> pool_id is not set"; exit 1 )
	terraform apply -auto-approve -target module.bastion_node -var 'rhn_username=${rhn_username}' -var 'rhn_password=${rhn_password}' -var 'pool_id=${pool_id}'

master_node:
	# Creating Master Node
	terraform apply -auto-approve -target module.master_node

infra_node:
	# Creating Infra Node
	terraform apply -auto-approve -target module.infra_node

app_node:
	# Creating App Nodes
	terraform apply -auto-approve -target module.app_node

remove_scripts:
	# Removing startup scripts from instances
	terraform apply -auto-approve -target module.remove_scripts
