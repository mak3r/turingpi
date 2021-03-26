#!/bin/sh

SECRET=$1
SERVER=$2
VERSION=$3

curl -sfL https://get.k3s.io | \
K3S_TOKEN="$SECRET" \
K3S_URL="$SERVER" \
INSTALL_K3S_VERSION="$VERSION" \
sh -
