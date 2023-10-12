#!/bin/bash

export account=`echo $1 | cut -c 1-3`

cd root
echo "123"
#terraform destroy -auto-approve -var-file=../conf/$account/$1.tfvars