#!/bin/sh

#VERSION="v1.18.16+k3s1"
#VERSION="v1.19.8+k3s1"
VERSION="v1.20.4+k3s1"

while getopts 'p' c
do
  case $c in
	p) PREP=1 ;;
  esac
done

if [ "$PREP" == "1" ]; then
	scripts/install.sh -m -p -n tp6 -t nfd 
	for i in {1,2,3,4,5,7}; do
		scripts/install.sh -w -p -n tp$i -t nfd -s https://turingpi06.lan:6443 
	done
else
	scripts/install.sh -m -n tp6 -t nfd -v $VERSION
	./scripts/pull-kubeconfig.sh -c kubeconfig-tpi -n tp6
	for i in {1,2,3,4,5,7}; do
		scripts/install.sh -w -n tp$i -t nfd -s https://turingpi06.lan:6443 -v $VERSION 
	done
fi

