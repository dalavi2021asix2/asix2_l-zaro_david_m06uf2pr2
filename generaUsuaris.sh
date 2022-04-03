#!/bin/bash
# David Lázaro Viagel
# Script 8

clear
echo -n "Quantitat d'usuaris a crear (entre 1 i 100)? "
read qt

if [[ $qt -gt 100 ]] || [[ $qt -lt 1 ]] 
then
    echo "El número que has introduït es incorrecte"
    exit 1
fi

echo -n "Valor inicial Uid Number?"
read vinic

if [[ -e nomUsuaris.ldif ]]
then
    rm nomUsuaris.ldif
fi

NumUsr=$vinic
for (( i=1; i<=$qt; i++))
do
	vinic=$((vinic+i))
	idUsr=usr$NumUsr

	echo "dn: uid=$idUsr,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" >> nousUsuaris.ldif
	echo "objectClass: top"  >> nousUsuaris.ldif
	echo "objectClass: person" >> nousUsuaris.ldif
	echo "objectClass: organizationalPerson" >> nousUsuaris.ldif
	echo "objectClass: inetOrgPerson" >> nousUsuaris.ldif
	echo "objectClass: posixAccount" >> nousUsuaris.ldif
	echo "objectClass: shadowAccount" >> nousUsuaris.ldif
	echo "cn: " $idUsr >> nousUsuaris.ldif
	echo "sn: " $idUsr >> nousUsuaris.ldif
	echo "uidNumber: " $NumUsr >> nousUsuaris.ldif
	echo "gidNumber: 101" >> nousUsuaris.ldif
	echo "homeDirectory: /home/$idUsr" >> nousUsuaris.ldif
	echo "loginShell: /bin/bash" >> nousUsuaris.ldif
	echo "objectClass: userPassword" >> ctsUsuaris.txt
	echo "" >> nousUsuaris.ldif
	((NumUsr++))

done
ldapadd -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -W -f nousUsuaris.ldif

echo "Usuaris creats correctament"
exit 0
