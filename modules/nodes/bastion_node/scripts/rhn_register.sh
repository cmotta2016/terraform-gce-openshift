#!/bin/bash
# Unregister with softlayer subscription

sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOF
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

sudo yum install google-cloud-sdk -y

username=$1
password=$2
poolID=$3

sudo subscription-manager register --username=$username --password=$password

sudo subscription-manager attach --pool=$poolID

sudo subscription-manager repos --disable="*" --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-ose-3.11-rpms --enable=rhel-7-server-ansible-2.6-rpms
sudo yum install openshift-ansible -y
sudo subscription-manager remove --all && sudo subscription-manager unregister && sudo subscription-manager clean
