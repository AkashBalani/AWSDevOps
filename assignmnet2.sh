#!/bin/bash

if ! grep -q aws_access_key_id ~/.aws/config; then
  if ! grep -q aws_access_key_id ~/.aws/credentials; then
    echo "AWS config not found or CLI not installed. Please run \"aws configure\"."
    exit 1
  fi
fi

echo "This script will create the CentOS VM."
read -r -p "Enter the VirtMich name: " VMName

echo " "
echo "====================================================="
echo "Creating VM with name: " vm-$VMName
aws ec2 run-instances --image-id ami-062f7200baf2fa504 \
--count 1 --instance-type t2.medium --key-name robust --security-groups Cent \
--region us-east-1 --user-data file://assignment2-meta.txt \
--tag-specification 'ResourceType=instance,Tags = [{Key=Name, Value='$VMName'}]'
