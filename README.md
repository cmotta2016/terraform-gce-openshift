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
1. Copy private key to bastion node. 

2. Create inventory file (use model in Install_Openshift directory)

On Bastion Node
1. Subscribe all instances:
```
$ ansible nodes -i inventory -b -m redhat_subscription -a "state=present username=<your_username> password=<your_password> pool_ids=<your_openshift_poolid>" 
```

2. Enable repos:
```
$ ansible nodes -i inventory -b -m shell -a \
    'subscription-manager repos --disable="*" \
    --enable="rhel-7-server-rpms" \
    --enable="rhel-7-server-extras-rpms" \
    --enable="rhel-7-server-ose-3.11-rpms" \
    --enable="rhel-7-server-ansible-2.6-rpms"'
```

3. Update packages and reboot instances
```
$ ansible all -i inventory -b -m yum -a "name=* state=latest"
$ ansible all -i inventory -b -m command -a "reboot"
```

4. Run prerequisites playbook
```
$ ansible-playbook -i inventory /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml
```

5. Run deploy playbook
```
$ ansible-playbook -i inventory /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml
```
