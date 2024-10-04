#!/usr/bin/env bash
#
# Certificates variables
CERTDIR="../certs/"
KEYNAME="privkey.pem"
CERTNAME="fullchain.pem"
VALID="1095"
DHNAME="dhparam.pem"

GLPI_URL="https://github.com/glpi-project/glpi/releases/download/10.0.16/glpi-10.0.16.tgz"
GLPI_DIR="../glpi-project/"
GLPI_ROOT_DIR="../"

_COMMAND=wget

# Functions
#
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
	echo ""
	echo "    Genereting certifictes using openssl..."
	openssl req -newkey rsa:2048 -nodes -keyout "$CERTDIR$KEYNAME" -x509 -days "$VALID" -out "$CERTDIR$CERTNAME"
	chmod -w "${CERTDIR}${CERTNAME}"
	chmod -w "${CERTDIR}${KEYNAME}"
	echo ""
	echo "    Certificate generate in $CERTDIR"
}

# Create dhparam function
dhparam_create(){
	echo "    This can take while. Please wait..."
	echo ""
	openssl dhparam -out "$CERTDIR$DHNAME" 2048
	chmod -w "$CERTDIR$DHNAME"
	echo ""
	echo "    dhparam generate finish. File available in $CERTDIR"
}

# Configure LetsEncrypt container on docker-compose
letsencrypt_create() {
	echo "letsencrypt created!"

}

# Create infra with others certificates files from user
use_own_cert(){
	echo ""
	echo "    Please ensure that files $CERTNAME and $KEYNAME are in the $CERTDIR directory before proceeding."
	echo ""
	echo "    Do files $CERTNAME and $KEYNAME are in the $CERTDIR directory? yes/no"	
	echo ""
	echo -n "    Your choice: "
	read -r test_cert
	echo ""

	# Test if yes was selected
	case $test_cert in
	    # Check if files exits
	    yes) if [ ! -f "${CERTDIR}${CERTNAME}" ] || [ ! -f "${CERTDIR}${KEYNAME}" ]; then
	                 echo "    ${CERTDIR}${CERTNAME} or ${CERTDIR}${KEYNAME} not found. Please ensure certificates are in $CERTDIR directory!" && exit 1
	         fi ;;
	    no) echo "    Please ensure that files is in $CERTDIR and try again!" && echo "" && exit 0 ;;
	    *) echo "    This options is not allowded! Let's try again." && echo "" && use_own_cert ;;
	esac

}

glpi_download(){
    if [ ! -d $GLPI_DIR ]; then
        wget "$GLPI_URL" -O "/tmp/glpi.tgz"
        tar -xf /tmp/glpi.tgz -C $GLPI_ROOT_DIR
        mv ${GLPI_ROOT_DIR}glpi ${GLPI_ROOT_DIR}glpi-project
    else
        echo "   The $GLPI_DIR directoy already exists. Keeping the existing directory."
	sleep 3
    fi
}

# Execution

# Interactive mode
echo "
	WARN: This process will remove all files in $CERTDIR directory!

	How will be the certificate configuration?

	1. By Letsencrypt
	2. By cert-create.sh script from this repository
	3. By using my own certificates files (dhparam.pem will be generated if not found)

"
echo -n "        Your choice: "
read -r option
echo ""

case $option in
    1) rm -rf "$CERTDIR*" \
	   && dhparam_create \
	   && sleep 3 \
	   && echo "" \
	   && letsencrypt_create \
	   && glpi_download ;;

    2) rm -rf "$CERTDIR*" \
	    && cert_create \
	    && sleep 3 \
	    && echo "" \
	    && dhparam_create \
	    && glpi_download ;;

    3)	    use_own_cert \
	    && if [ ! -f "${CERTDIR}${DHNAME}" ]; then
	           echo "    ${CERTDIR}${DHNAME} not found, so we will generate it." && dhparam_create
	       fi \
	    && glpi_download ;;
     *) echo "This option is not available!" && exit 1 ;;
esac


