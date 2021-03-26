# CM3+ Initial Setup

## Prep 
1. build usbboot to mount the module as a block device
	* https://github.com/raspberrypi/usbboot
	* on a current mac, I simply did `make` 
1. [Configure the cluster bus](https://docs.turingpi.com/turing_pi/children/i2c_cluster_bus/)
	* If an additional I2C controller is used
		* do _not_ set the pin values in /boot/config.txt
		* do set the `i2c-rtc` real time clock data
		* Wiring between the external I2C device and the turing pi
			* **IMPORTANT only wire up VCC (3.3v) if the external I2C device is using that as it's power source**
			* SDA <-> SDA
			* SCL <-> SCL
			* GND <-> GND : required on RPi device GPIO
			* VCC <-> X

## Flash the eMMC with an OS
1. insert the module in the device in flash mode
1. connect a usb cable
1. run `rpiboot` from the `usbboot/` previously built. Output looks like
	```
	Waiting for BCM2835/6/7/2711...
	Loading embedded: bootcode.bin
	Sending bootcode.bin
	Successful read 4 bytes
	Waiting for BCM2835/6/7/2711...
	Loading embedded: bootcode.bin
	Loading embedded: bootcode.bin
	Second stage boot server
	Loading embedded: start.elf
	File read: start.elf
	Second stage boot server done
	```
1. flash the chosen image to the device
	`pv 2020-08-20-raspios-buster-armhf-lite.img | sudo dd bs=1m of=/dev/disk2`

### OS specific post flash steps
These steps will vary depending on the OS selected. Commands will vary depending on the host OS

#### Raspbian
* Enable ssh access
	`touch /Volumes/boot/ssh`
* Enable 64bit userland
	```
	cat <<-EOF >> config.txt
	
	# enable 64bit
	arm_64bit=1
	EOF
	```
* Enable i2c
	```
	# enable i2c capabilities
	dtoverlay=i2c1,pins_44_45
	dtoverlay=i2c-rtc,mcp7940x
	```
* set the same locale for all in raspi-config

# Kubernetes

## Scripts to install in various configurations

* [cluster-7mw.sh](./scripts/cluster-7mw.sh) - Install 7 clusters with master/worker capability
* [cluster-1m6w.sh](./scripts/cluster-1m6w.sh) - Install 1 cluster with a single master and 6 worker nodes.

## Clean k3s off the nodes

* [clean-all.sh](./scripts/clean-all.sh) - clean it from all nodes

