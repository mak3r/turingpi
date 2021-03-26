#!/bin/sh

while getopts 'n:c:h' c
do
  case $c in
	n) NODE_ID=$OPTARG ;;
	c) CONFIG_NAME=$OPTARG ;;
	h)
	  echo "$0 -c <config_name> -n <node_id>"	  
	  exit 0
	  ;;
  esac
done

ssh "$NODE_ID" 'if [ ! -d ~/.kube ]; then mkdir ~/.kube; fi'
ssh "$NODE_ID" 'sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config'

scp "$NODE_ID":~/.kube/config "$CONFIG_NAME"
