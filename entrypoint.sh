#!/bin/sh
set -e

if [ ! -e sp-encrypt-cert.pem ]; then
	mv /etc/shibboleth.fred/ /etc/shibboleth/
	chown -R shibd:root .
fi
