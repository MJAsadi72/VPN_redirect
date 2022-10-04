#!/bin/bash

#this script install xt_geoip on centos
#you can use this instruction for installing on other distros
yum install gcc gcc-c++ iptables-devel kernel-devel kernel-devel-`uname -r` wget
cd /tmp/
wget -c https://sourceforge.net/projects/xtables-addons/files/Xtables-addons/xtables-addons-2.14.tar.xz
tar -xvf xtables-addons-2.14.tar.xz
cd xtables-addons-2.14
vi extensions/Kbuild
sed -i '/xt_TARPIT.o$/s/^/#/' extensions/Kbuild
./configure
make
make install
modprobe xt_geoip
mkdir /usr/share/xt_geoip/
wget -q https://legacy-geoip-csv.ufficyo.com/Legacy-MaxMind-GeoIP-database.tar.gz -O - | tar -xvzf - -C /usr/share/xt_geoip
