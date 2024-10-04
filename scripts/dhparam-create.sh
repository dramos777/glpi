#!/usr/bin/env bash
#Create files.pem needed for webserver

CERTDIR="../certs/"
DHNAME="dhparam.pem"

# Create dhparam
openssl dhparam -out "$CERTDIR$DHNAME" 4096

#Remove write permission on files
chmod -w $CERTDIR*
