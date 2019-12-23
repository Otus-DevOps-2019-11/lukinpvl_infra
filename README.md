# lukinpvl_infra
lukinpvl Infra repository

# homework #3 - cloud-bastion

bastion_IP = 35.206.133.35
someinternalhost_IP = 10.132.0.3

one-line command to connect via ssh to someinternalhost through bastion:

    ssh -i ~/.ssh/appuser -J appuser@35.206.133.35 appuser@10.132.0.3

ssh config file:

    Host someinternalhost
    	Hostname 10.132.0.3
    	ProxyJump appuser@35.206.133.35:22
    	User appuser
    	IdentityFile ~/.ssh/appuser
