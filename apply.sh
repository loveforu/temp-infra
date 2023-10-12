#!/bin/bash

export account=`echo $1 | cut -c 1-3`

cd root
# terraform plan -var-file=../conf/$account/$1.tfvars
# terraform ///apply -auto-approve -var-file=../conf/$account/$1.tfvars
echo "123"