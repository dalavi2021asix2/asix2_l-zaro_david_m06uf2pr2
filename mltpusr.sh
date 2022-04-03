#!/bin/bash

clear
if (( $EUID != 0 ))
then
  echo "This script must be run as a root"
  exit 1 
fi
aptitude search pwgen
if [[ $? != 0 ]]
then
apt-get install pwgen
fi
echo -n "Dona'm el nombre d'usuaris: "
read $num
if (( $num < 1 )) || (( $num > 30 ))
	then
	echo "Nombre incorrecte d'usuaris"
	exit 1		
fi
echo -n "Diga'm un nom base: "
read nombase
echo -n "Diga'm un UID inicial: "
read uid

echo "Usuaris" >> /root/$nombase
if [[ $? -ne 0 ]]
	then
	echo "Error creant el fitxer"
	exit 1
fi
echo "Llista: " >> /root/$nombase
for (( num=1; num<=$num; num++ ))
do
	password=$(pwgen 10 1)
	user=$nombase$num.clot
	echo "$user $password $uid" >> /root/$nombase
	useradd $nombase$num.clot -u $uid -g users -d /home/$nombase$num.clot -m -s /bin/bash -p $(mkpasswd $password)
	if (( $? != 0 ))
	then
		exit 2
	fi
	uid=$(expr $uid + 1)
done
exit 0
