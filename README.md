# Terraform provisioning Google Cloud infrastructure for Openshift cluster install
On Google Cloud
1. Create project
2. Registry DNS domain
3. Create account service with Role: Project > Editor ane create json key.
This .json file will be used by Terraform to provisioning infrastructure.

On Workstation
1. Install Terraform:
```
$ wget https://releases.hashicorp.com/terraform/0.12.3/terraform_0.12.3_linux_amd64.zip 
$ unzip terraform_0.12.3_linux_amd64.zip 
$ cp terraform /usr/local/bin
```

2. Install make:
```
$ apt update && apt install make -y
```

3. Clone this repo:
```
$ git clone https://github.com/cmotta2016/terraform-gce-openshift.git 
$ cd terraform-gce-openshift
```

4. Adjust files provider.tf and variable.tf

5. Create infrastructure:
```
$  make rhn_username=<your_username> rhn_password=<your_password> pool_id=<openshift_pool_id> infrastructure
```

6. To destroy the environment:
```
$ terraform destroy -auto-approve
```

Install Openshift
On Bastion Node
1. Create inventory using template file

2. Run prerequisites playbook
```
$ ansible-playbook -i inventory /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml
```

3. Run deploy playbook
```
$ ansible-playbook -i inventory /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml
```
