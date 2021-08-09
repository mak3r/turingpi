#!/bin/sh

for i in {1..7}; do
	echo "============= SHUTTING DOWN NODE turingpi0$i ============="
	ssh tp$i sudo shutdown -h now
done
