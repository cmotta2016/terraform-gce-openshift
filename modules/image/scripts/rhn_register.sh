#!/bin/bash
# Unregister with softlayer subscription

sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

username=$1
password=$2
poolID=$3

sudo subscription-manager register --username=$username --password=$password --auto-attach

#sudo subscription-manager attach --pool=$poolID

sudo subscription-manager repos --disable="*" --enable=rhel-7-server-rpms
