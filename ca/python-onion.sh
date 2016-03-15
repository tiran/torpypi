#!/bin/sh
# Written by Christian Heimes
set -e

export CAOUTDIR=out
export CATMPDIR=tmp

rm -rf $CATMPDIR

mkdir -p $CAOUTDIR
mkdir -p $CATMPDIR

touch $CATMPDIR/python-onion-ca.db
touch $CATMPDIR/python-onion-ca.db.attr
echo '01' > $CATMPDIR/python-onion-ca.crt.srl
echo '01' > $CATMPDIR/python-onion-ca.crl.srl


# root CA
openssl req -new \
    -config python-onion-ca.conf \
    -out $CATMPDIR/python-onion-ca.csr \
    -keyout $CAOUTDIR/python-onion-ca.key \
    -batch

openssl ca -selfsign \
    -config python-onion-ca.conf \
    -in $CATMPDIR/python-onion-ca.csr \
    -out $CAOUTDIR/python-onion-ca.pem \
    -extensions python_onion_ca_ext \
    -batch

openssl x509 \
    -inform pem \
    -in $CAOUTDIR/python-onion-ca.pem \
    -outform der \
    -out $CAOUTDIR/python-onion-ca.cer

# server cert signed by intermediate CA
openssl req -new \
    -config python-onion-cert.conf \
    -out $CATMPDIR/python-onion.csr \
    -keyout $CAOUTDIR/python-onion.key \
    -batch

openssl ca \
    -config python-onion-ca.conf \
    -in $CATMPDIR/python-onion.csr \
    -out $CAOUTDIR/python-onion.pem \
    -policy match_pol \
    -extensions python_onion_server_ext \
    -batch

echo DONE
