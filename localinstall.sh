#!/bin/bash

FILE=/usr/local/bin/samplicate

if [ -f "$FILE" ]; then

	echo "Samplicate already installed."
	
	sudo /usr/local/bin/samplicate -S -c /opt/samplicator/etc/samplicator.conf -p 9090 -f -4 -m /opt/samplicator/etc/samplicate.pid
	
	cat /opt/samplicator/etc/samplicate.pid
	
else

	sudo apt-get update && sudo apt-get upgrade -y

	sudo apt-get install make git autoconf automake gcc systemd-sysv libx32gcc1 runc -y

	git clone https://github.com/sleinen/samplicator

	cd ./samplicator

	sudo ./autogen.sh

	sudo ./configure

	sudo make

	sudo make install

	sudo mkdir -p /opt/samplicator/etc/

	sudo cp ../samplicator.conf /opt/samplicator/etc/samplicator.conf

	sudo /usr/local/bin/samplicate -S -c /opt/samplicator/etc/samplicator.conf -p 9090 -f -4 -m /opt/samplicator/etc/samplicate.pid
	cat /opt/samplicator/etc/samplicate.pid

fi
