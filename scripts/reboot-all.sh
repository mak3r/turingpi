#!/bin/sh

for i in {1..7}; do
	echo "============= REBOOTING NODE turingpi0$i ============="
	ssh tp$i sudo reboot
done