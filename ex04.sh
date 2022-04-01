#!/bin/bash

clear
if (( $EUID != 0 )) # $EUID = 0 if you are running the script with root privileges
then
  echo "This script must be run as a root"
  exit 1 
fi

DATA=$(date +20%y%m%d%H%M)

# saber si un directorio existe
if [[ ! -d /root/$1 ]]
then
	echo "Vols crear-lo (s/n): "
	read opc
	if [[ $opc == "s" ]]
	then
		mkdir /root/$1
		cp /etc/resolv.conf /root/$1/resolv.conf.backup.$DATA
		cd /root/$1
		for a in resolv.conf.backup.$DATA
		do
			gzip $a
		done
		echo "Comprimido"
		exit 0
	else
		echo "No puc continuar sense aquest directori"
		exit 1
	fi
	else
	cp /etc/resolv.conf /root/$1/resolv.conf.backup.$DATA
	cd /root/$1
	for a in resolv.conf.backup.$DATA
	do
		gzip $a
	done
	echo "Comprimido"
	exit 0
fi
