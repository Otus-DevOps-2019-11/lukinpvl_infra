# lukinpvl_infra
lukinpvl Infra repository

# homework #9 - ansible-2
Prepared ansible playbooks for Reddit app with templates and headlers

# homework #8 - ansible-1
After deleting reddit directory (rm -rf ~/reddit) ansible status changed from 'changed=0' to 'changed=1'

Exercise with *
added python script to get VM instances information from gcp
added dynamic inventory for ansible

# homework #7 - terraform-2
Created terraform config with backend in bucket (ex*) for ready-to-use (ex**) puma application with app and db modules

# homework #6 - terraform-1
Created terraform config for puma appliaction
how to use:
	1) execute terraform apply to deploy puma application
	2) check it on EXTERNAL_IP:9292

Exercise with *
to adding additional ssh keys:
    	ssh-keys = "appuser:${file(var.public_key_path)} appuser1:${file(var.public_key_path)} appuser2:${file(var.public_key_path)}"

manually added ssh keys deleted after executing the terraform apply command
there is no problem on this step

Exercise with **
created and checked load balancer for puma appplication servers group (count used)
	terraform conf file: ./terraform/lb.tf.example

# homework #5 - packer-base

Created packer template for puma appliaction
how to use:
	1) start config_scripts/create-reddit-vm.sh to deploy puma application
	2) check it on EXTERNAL_IP:9292

# homework #4 - cloud-testapp

testapp_IP = 35.233.49.23

testapp_port = 9292

create firewall rule cli:

    gcloud compute firewall-rules create default-puma-server \
    --direction=INGRESS \
    --priority=1000 \
    --network=default \
    --action=ALLOW \
    --rules=tcp:9292 \
    --source-ranges=0.0.0.0/0 \
    --target-tags=puma-server

create vm instanse cli:

    gcloud compute instances create reddit-app \
    --zone=europe-west1-b \
    --boot-disk-size=10GB \
    --image-family ubuntu-1604-lts \
    --image-project=ubuntu-os-cloud \
    --machine-type=g1-small \
    --tags puma-server \
    --restart-on-failure \
    --metadata \
    startup-script-url=gs://infra_bucket1/startup_script.sh

# homework #3 - cloud-bastion

bastion_IP = 35.206.151.127

someinternalhost_IP = 10.132.0.6

one-line command to connect via ssh to someinternalhost through bastion:

    ssh -i ~/.ssh/appuser -J appuser@35.206.151.127 appuser@10.132.0.6

ssh config file:

    Host someinternalhost
    	Hostname 10.132.0.6
    	ProxyJump appuser@35.206.151.127:22
    	User appuser
    	IdentityFile ~/.ssh/appuser
