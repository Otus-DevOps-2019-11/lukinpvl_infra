#!/bin/sh
gcloud compute instances create reddit-app \
	--zone=europe-west1-b \
	--machine-type=f1-micro \
	--image-family reddit-full \
	--tags puma-server
