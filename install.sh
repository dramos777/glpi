#!/usr/bin/env bash
#
# Certificates variables
CERTDIR="./certs/"
KEYNAME="privkey.pem"
CERTNAME="fullchain.pem"
VALID="1095"
DHNAME="dhparam.pem"


#Create Certificates function
cert_create() {
	echo "Genereting certifictes using openssl..."
	openssl req -newkey rsa:4096 -nodes -keyout "$CERTDIR$KEYNAME" -x509 -days "$VALID" -out "$CERTDIR$CERTNAME"
	chmod -w "${CERTDIR}${CERTNAME}"
	chmod -w "${CERTDIR}${KEYNAME}"
	echo "Certificate generate in $CERTDIR"
}

#Remove write permission on files
# Create dhparam function
dhparam_create(){
	echo "Genereting dhparam..."
	openssl dhparam -out "$CERTDIR$DHNAME" 4096
	chmod -w "$CERTDIR$DHNAME"
	echo "dhparam generate finish. File available in $CERTDIR"
}

letsencrypt_create() {
	echo "Creating infra with Letsencrypt. This can take some minutes..."

}

# Interactive mode
echo "
	How will be the certificate configuration?

	1. By Letsencrypt
	2. By cert-create.sh script from this repository
	3. By my own certificates files

"
echo -n "Type your choice: "
read -r option

case $option in
    1) dhparam_create \
	   && sleep 3 \
	   && echo "" \
	   && letsencrypt_create \
	   && exit 0 ;;

    2) cert_create \
	    && sleep 3 \
	    && echo "" \
	    && dhparam_create \
	    && exit 0 ;;

    3) echo "This is option 3" ;;
     *) echo "This is any other option" && exit 1 ;;
esac


