# Terraform
Terraform is a powerful open source tool for building, changing, and versioning your infrastructure deployments in a safely and efficient manner. Terraform can be used to manage existing infrastructures, popular service providers as well as custom in-house solutions and implementations. Terraform uses configuration files which describes the components needed to run a single application or your entire datacenter, and desired state will be effected.

we will be deploying terraform to automate instance creation on OpenStack Cloud platform. The OpenStack can be on self-hosted infrastructure or a public managed service offering. All that is required is OpenStack API endpoint that can be accessed from the machine where terraform is installed.

## Steps
sudo apt update
sudo apt install wget curl unzip
### Download & install Terraform
TER_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
unzip terraform_${TER_VER}_linux_amd64.zip

## move terraform from current directory to bin dir 
sudo mv terraform /usr/local/bin/

## 
ssh-keygen # if you don't have ssh keys already

## Upload the public key to Openstack. This key will be used during instance creation for passwordless authentication.

openstack keypair create --public-key ~/.ssh/id_rsa.pub admin
openstack keypair list
## Create clouds.yml file
vim ~/.config/openstack/clouds.yaml

## insert data from cloud.yaml file in this repo

## Create log file

touch ~/openstackclient_admin.log

## check imgae, service flavor etcterraform apply

openstack service list  --os-cloud osp_admin
openstack image list
openstack flavor list
openstack network list

## run terraform for main.tf which is found in repo
terraform init
terraform plan
terraform apply


