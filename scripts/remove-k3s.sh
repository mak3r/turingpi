#!/bin/sh

if which k3s-uninstall.sh; then
	k3s-uninstall.sh &
fi
if which k3s-agent-uninstall.sh; then
	k3s-agent-uninstall.sh &
fi

wait $!