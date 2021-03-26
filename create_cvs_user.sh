
#!/bin/bash
#
# Automaticamente crea usuario cvs en prodlocal
#

STR=123_$1_456
PASS=$(mkpasswd $STR --method=SHA-512)

if [ $# -lt 1 ];then
	echo "Recibo como parametro un nombre de usuario"
	exit 1
fi

ansible -vvv -i prod prod-local -u root -m user -a "name=$1 password=$PASS group=cvs" 