#!/bin/bash

if [ ! -f $(which openssl) ]; then
	echo "You need openssl to do this"
	exit
fi

if [ -z $1 ]; then
	echo "Usage: $0 <name>"
	echo ""
	echo "Will generate <name>.pem <name>.pk8 <name>.x509.pem"
	exit
fi
openssl genrsa -3 -out $1.pem 2048
openssl req -new -x509 -key $1.pem -out $1.x509.pem -days 10000 \
	-subj "/C=TW/ST=Taiwan/L=Taipei/O=APK Repacker/OU=APKRP/CN=email@mail.mail"
openssl pkcs8 -in $1.pem -topk8 -outform DER -out $1.pk8 -nocrypt

#echo "Please enter the password for this key:"
#openssl pkcs8 -in $1.pem -topk8 -outform DER -out $1.pk8 -passout stdin
