# Terraform provisioning Google Cloud infrastructure for Openshift cluster install
On Google Cloud

1. Criar projeto e habilitar faturamento
2. Registrar DNS público
3. Criar conta de serviço Role: Projeto > Editor O arquivo .json gerado será usado no arquivo provider do terraform

On Workstation
1. Instala o Terraform
```
$ wget https://releases.hashicorp.com/terraform/0.12.3/terraform_0.12.3_linux_amd64.zip 
$ unzip terraform_0.12.3_linux_amd64.zip 
$ cp terraform /usr/local/bin
```

2. Install make 
$ apt update && apt install make -y

3. Clona o repositório 
$ git clone https://github.com/cmotta2016/terraform-gce-openshift.git cd terraform-gce-openshift

4. Ajustar os arquivos provider.tf e variable.tf de acordo com seu ambiente

5. Executar o comando:
$  make rhn_username=<your_username> rhn_password=<your_password> pool_id=<openshift_pool_id> infrastructure

6. Para destruir o ambiente 
$ terraform destroy -auto-approve
