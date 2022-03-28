#!/usr/bin/env bash
set -eu
org=localhost-ca
domain=localhost

openssl genpkey -algorithm RSA -out ca.key
openssl req -x509 -key ca.key -out ca.crt \
    -subj "/CN=$org/O=$org"

openssl genpkey -algorithm RSA -out "$domain".key
openssl req -new -key "$domain".key -out "$domain".csr \
    -subj "/CN=$domain/O=$org"

openssl x509 -req -in "$domain".csr -days 365 -out "$domain".crt \
    -CA ca.crt -CAkey ca.key -CAcreateserial \
    -extfile <(cat <<END
basicConstraints = CA:FALSE
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
subjectAltName = DNS:$domain
END
    )

openssl pkcs12 -export -out "$domain".pfx -inkey "$domain".key -in "$domain".crt