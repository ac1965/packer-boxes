#!/bin/sh

sudo -s sh<<EOF

# Setup timezone
rm /etc/localtime
ln -s /usr/share/zoneinfo/America/Boise /etc/localtime

#Set the time correctly
ntpdate -v -b in.pool.ntp.org

date > /etc/vagrant_box_build_time

# Setup vagrant user
pkg_add -r bash
chsh -s /usr/local/bin/bash vagrant
cd /home/vagrant
mkdir -m 700 .ssh
fetch https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub
mv vagrant.pub .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
chown -R vagrant:vagrant .ssh

pw groupadd vboxusers
pw groupmod vboxusers -m vagrant

EOF

