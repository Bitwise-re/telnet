
all:
	rm -f telnet
	gcc telnet.c -o telnet
	chmod o+x telnet
