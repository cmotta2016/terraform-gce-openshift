#!/bin/bash
# Unregister with softlayer subscription

sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

username=$1
password=$2
poolID=$3

sudo subscription-manager register --username=$username --password=$password

sudo subscription-manager attach --pool=$poolID

sudo subscription-manager repos --disable="*" --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-ose-3.11-rpms --enable=rhel-7-server-ansible-2.6-rpms
sudo yum install openshift-ansible -y
sudo subscription-manager remove --all && sudo subscription-manager unregister && sudo subscription-manager clean
