#!/bin/bash

BOOT_VOLUME="/boot"

if [ "$1" != "" ]; then 
	BOOT_VOLUME=$1
fi

touch $BOOT_VOLUME/ssh

if ! grep --quiet -E "arm_64bit" "$BOOT_VOLUME/config.txt"; then
	cat <<-EOF >> "$BOOT_VOLUME/config.txt"
	
	# enable 64bit
	arm_64bit=1
	EOF
fi

if ! grep --quiet -E "dtoverlay=i2c" "$BOOT_VOLUME/config.txt"; then
	cat <<-EOF >> "$BOOT_VOLUME/config.txt"
	
	# enable i2c capabilities
	dtoverlay=i2c1,pins_44_45
	dtoverlay=i2c-rtc,mcp7940x
	EOF
fi

if ! grep --quiet -E "cgroup" "$BOOT_VOLUME/cmdline.txt"; then
	sed -i 's/$/ cgroup_memory=1 cgroup_enable=memory/' "/$BOOT_VOLUME/cmdline.txt"
fi

# Disable swap
if systemctl list-unit-files --state enabled | grep dphys-swapfile; then
	systemctl stop dphys-swapfile.service
	systemctl disable dphys-swapfile.service
fi

if iptables --version | grep nf_tables; then
	iptables -F
	update-alternatives --set iptables /usr/sbin/iptables-legacy
	update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
fi