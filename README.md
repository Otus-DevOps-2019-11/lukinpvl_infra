# lukinpvl_infra
lukinpvl Infra repository

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
