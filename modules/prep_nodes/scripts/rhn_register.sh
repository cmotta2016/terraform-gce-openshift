#!/bin/bash

username=$1
password=$2
poolID=$3

ansible nodes -i /tmp/hosts -b -m redhat_subscription -a "state=present username=$username password=$password pool_ids=$poolID"

ansible nodes -i /tmp/hosts -b -m shell -a 'subscription-manager repos --disable="*" --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-ose-3.11-rpms --enable=rhel-7-server-ansible-2.6-rpms'

ansible all -i /tmp/hosts -b -m yum -a "name=* state=latest"
ansible all -i /tmp/hosts -b -m command -a "shutdown -r +1"
