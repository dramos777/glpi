#!/usr/bin/env bash
#
# Certificates variables
CERTDIR="./certs/"
KEYNAME="privkey.pem"
CERTNAME="fullchain.pem"
VALID="1095"
DHNAME="dhparam.pem"

_COMMAND=wget

# Check if wget is installed
check_wget_install() {
    local _command=$_COMMAND

    if command -v "$_command" > /dev/null 2>&1; then
        continue
    else
        echo "$_command is not installed. Please install $_command and try again."
    fi
}

# Create Certificates function
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

# Function to create infra with others certificates files from user
use_own_cert(){
	echo "Please ensure files $CERTNAME and $KEYNAME is in $CERTDIR before continue."
	echo "
	Do files $CERTNAME and $KEYNAME is in $CERTDIR? yes/no 
	"	
	read -r test_cert

	# Test if yes was selected
	if [ $test_cert = yes ]; then

		# Check if fullchain.pem exits
            if [ -f "${CERTDIR}${$CERTNAME}" ]; then
	        continue 
	    else
	        echo "File $CERTNAME not found." && exit 1
            fi

		# Check if privkey.pem exits
            if [ -f "${CERTDIR}${KEYNAME}" ]; then
	        continue
	    else
	        echo "File $KEYNAME not found." && exit 1
	    fi

	fi
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
	   && letsencrypt_create ;;

    2) cert_create \
	    && sleep 3 \
	    && echo "" \
	    && dhparam_create ;;

    3) use_own_cert \
	    && dhparam_create ;;
     *) echo "This option is not available!" && exit 1 ;;
esac


