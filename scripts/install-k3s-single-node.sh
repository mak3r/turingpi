#!/bin/sh

VERSION=$1
HOSTNAME=`hostname`

curl -sfL https://get.k3s.io | \
INSTALL_K3S_EXEC=" \
--write-kubeconfig-mode 644 \
--tls-san $HOSTNAME.lan \
--tls-san $HOSTNAME
--bind-address $HOSTNAME.lan \
" \
INSTALL_K3S_VERSION="$VERSION" \
sh -