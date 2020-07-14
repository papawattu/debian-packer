#!/bin/sh

set -e

if [ $1 ]; then
  fs=$1
elif [ $VAGRANT_BUILDER_FS ]; then
  fs=$VAGRANT_BUILDER_FS
else
  echo "usage: $0 ROOTFS";
  exit 1
fi

set -x


chroot $fs curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
chroot $fs add-apt-repository "deb https://apt.kubernetes.io/ kubernetes-xenial main"
chroot $fs apt-get update
chroot $fs apt-get install -qy kubelet kubeadm kubectl

echo "Kubernetes installed - pulling images"

chroot $fs kubeadm config images pull

echo "Images pulled"