#!/bin/sh

for i in {1..7}; do
	echo "============= CLEANING NODE $i ============="
	./scripts/install.sh -r -n tp$i
done