#!/bin/sh

SECRET=$1
VERSION=$2
HOSTNAME=`hostname`

curl -sfL https://get.k3s.io | \
INSTALL_K3S_EXEC=" \
--disable-agent \
--write-kubeconfig-mode 644 \
--tls-san $HOSTNAME.lan \
--tls-san $HOSTNAME \
--token $SECRET \
--bind-address $HOSTNAME.lan \
" \
INSTALL_K3S_VERSION="$VERSION" \
sh -