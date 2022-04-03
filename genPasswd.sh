#!/bin/bash
# David Lázaro Viagel
# Script 9

clear
if (( $EUID != 0 ))
then
  echo "This script must be run as a root"
  exit 1 
fi

aptitude search pwgen
if (( $? == 0 )) 
then
	aptitude install pwgen
fi

echo -n "Quants usuaris vols crear? (Entre 1 i 100): "
read usr

if (( $usr < 101 )) && (( $usr > 0 ))
then
	echo "Es crearan $usr usuaris"
else
	echo "El número que has introduït es incorrecte"
	exit 1
fi

echo -n "Introdueix el primer valor UID dels usuaris: "
read uid

echo "Usuaris creats" > /root/ctsUsuaris.txt

for (( c=1; c<=$usr; c++ )) # START=1 END=10 INCREMENT=1
do
	nomUsuari=usr$uid
	
	password=$(pwgen 10 1)
	echo "$nomUsuari $contrasenya" >> /root/ctsUsuaris.txt
	
	useradd $nomUsuari -u $uid -g users -d /home/$nomUsuari -m -s /bin/bash -p $(mkpasswd $password)
	if (( $? != 0 ))
	then
		exit 2
	fi
	uid=$(( $uid + 1 ))
	
done

echo "Script finalitzat satisfactoriament, contingut de /root/ctsUsuaris.txt"

cat /root/ctsUsuaris.txt
exit 0
