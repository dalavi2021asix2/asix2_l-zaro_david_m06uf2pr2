#!/bin/bash
# David Lázaro Viagel
# Script 4

clear
if (( $EUID != 0 )) # $EUID = 0 if you are running the script with root privileges
then
  echo "This script must be run as a root"
  exit 1 
fi

DATA=$(date +20%y%m%d%H%M)
echo "Benvingut a la configuració de DHCP"
echo "Nom del domini: "
read dom
echo "Indica l'adreça IP del servidor DNS: "
read dns
echo "Indica l'adreça IP del Router: "
read iprout
echo "Indica el valor per defecte del temps de leasing: "
read lease
echo "Indica el valor màxim del temps de leasing: "
read leasemax
echo "Indica l'adreça IP de la subxarxa: "
read ipsub
echo "Indica la màscara de subxarxa: "
read masc
echo "Indica la primera adreça IP del marge: "
read ipini
echo "Indica la darrera adreça IP del marge: "
read ipfin
cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.$DATA
echo "authoritative;" > /etc/dhcp/dhcpd.conf
echo "ddns-update-style none;" >> /etc/dhcp/dhcpd.conf
echo "option domain-name $dom;" >> /etc/dhcp/dhcpd.conf
echo "option domain-name-servers $dns;" >> /etc/dhcp/dhcpd.conf
echo "option routers $iprout;" >> /etc/dhcp/dhcpd.conf
echo "default-lease-time $lease;" >> /etc/dhcp/dhcpd.conf
echo "max-lease-time $leasemax;" >> /etc/dhcp/dhcpd.conf
echo "subnet $ipsub netmask $masc {" >> /etc/dhcp/dhcpd.conf
echo "  range $ipini $ipfin;" >> /etc/dhcp/dhcpd.conf
echo "}" >> /etc/dhcp/dhcpd.conf
service isc-dhcp-server restart
exit 0
