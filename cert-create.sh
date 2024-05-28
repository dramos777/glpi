#!/usr/bin/env bash
#Create files.pem needed for webserver

CERTDIR="./certificates/"
KEYNAME="privkey.pem"
CERTNAME="fullchain.pem"
DHNAME="dhparam.pem"
VALID="365"

#Create Certificates
openssl req -newkey rsa:2048 -nodes -keyout "$CERTDIR$KEYNAME" -x509 -days "$VALID" -out "$CERTDIR$CERTNAME" && openssl dhparam -out "$CERTDIR$DHNAME" 2048

#Remove write permission on files
chmod -w $CERTDIR*
