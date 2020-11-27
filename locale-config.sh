#!/bin/bash

sed -i'.~' 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
sed -i'.~' 's/en_GB.UTF-8 UTF-8/# en_GB.UTF-8 UTF-8/g' /etc/locale.gen
sed -i'.~' '/XKBLAYOUT/ s/".*"/"us"/g'  /etc/default/keyboard


export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
update-locale LANG=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales -phigh
dpkg-reconfigure keyboard-configuration -phigh