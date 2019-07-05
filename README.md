# terraform-gce-openshift

On Google Cloud
1. Criar projeto e habilitar faturamento
2. Registrar DNS público
3. Criar conta de serviço
Role: Projeto > Editor
O arquivo .json gerado será usado no arquivo provider do terraform

On Workstation
1. Instala o Terraform
wget https://releases.hashicorp.com/terraform/0.12.3/terraform_0.12.3_linux_amd64.zip
unzip terraform_0.12.3_linux_amd64.zip
cp terraform /usr/local/bin

2. Install make
apt update && apt install make -y

3. Generate ssh key pair
ssh-keygen -t rsa -f ~/.ssh/<ssh_name_key> -C <google_user>

4. Clona o repositório
git clone https://github.com/cmotta2016/terraform-gce-openshift.git
cd terraform-gce-openshift

5. Ajustar os arquivos provider.tf e variable.tf de acordo com seu ambiente

6. Executar o comando 
make rhn_username=carlos.motta.inovatech rhn_password=P@ssw0rd! pool_id=8a85f99b6b498682016bbec0d01111a2 create_base_image bastion_node master_node infra_node app_node remove_scripts

7. Para destruir o ambiente
terraform destroy -auto-approve
