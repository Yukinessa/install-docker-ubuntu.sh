#!/bin/bash

#yukinessa documentation

echo ""
echo "install docker for ubuntu by download package using script"

# is it ubuntu
DISTRO=$(ls /usr/src | grep linux > /dev/null;echo $?)
CODENAME=$(lsb_release -c| cut -d ":" -f2| awk '{print $1}')
if [[ "$DISTRO" != "0" ]]; then
	#statements
	echo ""
	echo "this is not linux "
	echo "abort the command"
	exit 112
fi

echo ""
echo "okai, this distro is ubuntu. wait, I'll check docker exists on your system or not."

ISDOCKEREXISTS=$(which docker > /dev/null 2>&1;echo $?)
if [[ $ISDOCKEREXISTS != 1 ]]; then
	#statements
	echo ""
	echo "the docker is already installed on your machine"
	echo "command aborted, please remove the docker first if you want to test this script"
	exit 212
fi

echo "okai, there is no docker in your machine,preceding the process"
echo ""
echo "get your architecture"

ISAMD64BIT=$(uname -i| grep x86_64 > /dev/null;echo $?)

if [[ $ISAMD64BIT != 0 ]]; then
	#statements
	echo ""
	echo "sorry, this script only for amd64 or x86_64 bit architecture "
	echo "abort the command"
	exit 312
fi

echo ""
echo "nice, this computer using ubuntu and have amd64/x86_64 architecture. continue installation...."

WGETSTATS=$(which wget > /dev/null 2>&1;echo $?)

if [[ $WGETSTATS != 0 ]]; then
	#statements
	echo ""
	echo "you have no wget in this machine"
	echo "please install wget first before execute this script"
	exit 412
fi

echo "you also already have wget. start download the package."
echo "this script will download docker deb file, and put it on your $HOME folder"
echo "download the package from this url : https://download.docker.com/linux/ubuntu/dists/$CODENAME/pool/stable/amd64/docker-ce_18.06.1~ce~3-0~ubuntu_amd64.deb"
cd $HOME && wget https://download.docker.com/linux/ubuntu/dists/$CODENAME/pool/stable/amd64/docker-ce_18.06.1~ce~3-0~ubuntu_amd64.deb && echo "download finished."

echo ""
echo "now, installing those docker package using command : sudo dpkg -i $HOME/docker-ce_18.06.1~ce~3-0~ubuntu_amd64.deb"
echo "you might have to enter your user password"
sudo dpkg -i $HOME/docker-ce_18.06.1~ce~3-0~ubuntu_amd64.deb

echo ""
echo "for make sure the service running, executing sudo service docker restart"
sudo service docker restart

echo ""
echo "docker is installed on your machine"
echo "end of script"
echo ""
