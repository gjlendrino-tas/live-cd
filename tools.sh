#!/bin/bash


# fdisk /dev/sdb <<EOF
# n
# p
# 1
# 
# 
# w
# q
# EOF
# mkfs.xfs /dev/sdb1
# mkdir /mnt/tools
mount /dev/sdb1 /mnt/tools/
echo "ubuntu:tase.1988" | chpasswd
echo "root:tase.1988" | chpasswd
if [ ! -d /mnt/tools/openssh-server-offline ]; then
  mkdir /mnt/tools/openssh-server-offline
  apt install -y --download-only openssh-server
  mv /var/cache/apt/archives/*.deb /mnt/tools/openssh-server-offline/
fi
apt install -y /mnt/tools/openssh-server-offline/*.deb
echo "PermitRootLogin yes" | tee -a /etc/ssh/sshd_config
systemctl restart ssh
ip a
umount /mnt/tools/
