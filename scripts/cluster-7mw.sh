#!/bin/sh

while getopts 'p' c
do
  case $c in
	p) PREP=1 ;;
  esac
done

if [ "$PREP" == "1" ]; then
	for i in {1..7}; do
		echo "============= INSTALLING ON NODE $i ============="
		scripts/install.sh -w -p -n tp$i -t nfd -s https://turingpi06.lan:6443
	done
else
	for i in {1..7}; do
		echo "============= INSTALLING ON NODE $i ============="
		scripts/install.sh -w -n tp$i -t nfd -s https://turingpi06.lan:6443 
	done
fi
