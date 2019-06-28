#!/bin/bash
DOCKERDEVICE=$(readlink -f /dev/disk/by-id/google-*docker*)
DOCKERDIR="/var/lib/docker"

mkfs.xfs ${DOCKERDEVICE}
mkdir -p ${DOCKERDIR}
restorecon -R ${DOCKERDIR}

echo UUID=$(blkid -s UUID -o value ${DOCKERDEVICE}) ${DOCKERDIR} xfs defaults,discard 0 2 >> /etc/fstab
mount -a
