#!/usr/bin/env bash
#Create files.pem needed for webserver

CERTDIR="../certs/"
KEYNAME="privkey.pem"
CERTNAME="fullchain.pem"
VALID="1095"

#Create Certificates
openssl req -newkey rsa:4096 -nodes -keyout "$CERTDIR$KEYNAME" -x509 -days "$VALID" -out "$CERTDIR$CERTNAME"

#Remove write permission on files
chmod -w $CERTDIR*
