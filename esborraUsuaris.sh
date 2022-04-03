#!/bin/bash
# David Lázaro Viagel
# Script 10

clear
if (( $EUID != 0 ))
then
  echo "This script must be run as a root"
  exit 1 
fi

echo -n "Quants has creat anteriorment (entre 1 i 100)? "
read qt

if [[ $qt -gt 100 ]] || [[ $qt -lt 1 ]] 
then
    echo "El número que has introduït es incorrecte"
    exit 1
fi

echo -n "Valor inicial Uid Number utilitzat en la creació? (Mínim 5000) "
read vinic
vinic=$((vinic-1))

if [[ $vinic < 5000 ]] 
then
    echo "El número que has introduït es erroni"
    exit 0
fi

if [[ -e esborraUsuaris.ldif ]]
then
    rm esborraUsuaris.ldif
fi

NumUsr=$vinic
for (( i=1; i<=$qt; i++))
do
	vinic=$((vinic+i))
	idUsr=usr$NumUsr

	echo "dn: uid=$idUsr,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" >> esborraUsuaris.ldif
	echo "objectClass: top"  >> esborraUsuaris.ldif
	echo "objectClass: person" >> esborraUsuaris.ldif
	echo "objectClass: organizationalPerson" >> esborraUsuaris.ldif
	echo "objectClass: inetOrgPerson" >> esborraUsuaris.ldif
	echo "objectClass: posixAccount" >> esborraUsuaris.ldif
	echo "objectClass: shadowAccount" >> esborraUsuaris.ldif
	echo "cn: " $idUsr >> esborraUsuaris.ldif
	echo "sn: " $idUsr >> esborraUsuaris.ldif
	echo "uidNumber: " $NumUsr >> esborraUsuaris.ldif
	echo "gidNumber: 101" >> esborraUsuaris.ldif
	echo "homeDirectory: /home/$idUsr" >> esborraUsuaris.ldif
	echo "loginShell: /bin/bash" >> esborraUsuaris.ldif
	echo "objectClass: userPassword" >> ctsUsuaris.txt
	echo "" >> esborraUsuaris.ldif
	((NumUsr++))

done
ldapdelete -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -W -f esborraUsuaris.ldif

echo "S'han esborrat correctament"
exit 0
