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

chroot $fs apt-get install -qy apt-transport-https ca-certificates curl gnupg-agent software-properties-common
chroot $fs curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
chroot $fs add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
chroot $fs apt-get update
chroot $fs apt-get install -qy docker-ce docker-ce-cli containerd.io
chroot $fs usermod -aG docker vagrant

echo "Docker installed"

