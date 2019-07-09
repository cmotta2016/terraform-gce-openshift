#!/bin/bash
sudo yum remove irqbalance cloud-init rhevm-guest-agent-common kexec-tools microcode_ctl rpcbind cloud-utils-growpart -y
sudo yum install google-compute-engine python-google-compute-engine rng-tools acpid firewalld gce-disk-expand -y
#sudo yum update -y
sudo systemctl enable rngd google-accounts-daemon google-clock-skew-daemon google-shutdown-scripts google-network-daemon

sleep 2
sudo yum clean all && sudo rm -rf /var/cache/yum && sudo logrotate -f /etc/logrotate.conf && sudo rm -f /var/log/*-???????? /var/log/*.gz && sudo rm -f /var/log/dmesg.old /var/log/anaconda/* && cat /dev/null | sudo tee /var/log/audit/audit.log && cat /dev/null | sudo tee /var/log/wtmp && cat /dev/null | sudo tee /var/log/lastlog && cat /dev/null | sudo tee /var/log/grubby && sudo rm -f /etc/udev/rules.d/70-persistent-net.rules  /etc/udev/rules.d/75-persistent-net-generator.rules /etc/ssh/ssh_host_* /home/cloud-user/.ssh/* && export HISTSIZE=0

sleep 2
sudo subscription-manager remove --all && sudo subscription-manager unregister && sudo subscription-manager clean
