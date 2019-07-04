create_base_image:	
	@[ "${rhn_username}" ] || ( echo ">> rhn_username is not set"; exit 1 )
	@[ "${rhn_password}" ] || ( echo ">> rhn_password is not set"; exit 1 )
#	@[ "${pool_id}" ] || ( echo ">> pool_id is not set"; exit 1 )


	terraform apply -auto-approve -target module.network -target google_compute_project_metadata_item.ssh-key
	terraform apply -auto-approve -target module.create_temp_image -var 'rhn_username=${rhn_username}' -var 'rhn_password=${rhn_password}'
	terraform apply -auto-approve -target module.create_base_image
	terraform destroy -auto-approve -target module.create_temp_image

bastion_node:
	terraform apply -auto-approve -target module.bastion_node -var 'rhn_username=${rhn_username}' -var 'rhn_password=${rhn_password}' -var 'pool_id=${pool_id}'
#	terraform apply -auto-approve -target module.bastion_node
#

master_node:
	terraform apply -auto-approve -target module.master_node


infra_node:
	terraform apply -auto-approve -target module.infra_node
