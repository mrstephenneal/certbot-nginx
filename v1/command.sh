#!/usr/bin/env bash

# Check if staging is enabled via ENV vars
if [ ${staging} -gt 0 ]
then
    staging_cmd="--staging"
else
    staging_cmd=""
fi

# Delete dummy certificate for ${domain}
rm -Rf /etc/letsencrypt/live/${domain} \
    && rm -Rf /etc/letsencrypt/archive/${domain} \
    && rm -Rf /etc/letsencrypt/renewal/${domain}.conf

# TODO: Pull SSL certs from AWS S3

# TODO: Check certificate expiration date

# TODO: run lets encrypt if certificate is going to expire
# Request Let's Encrypt certificate for ${domain}
certbot certonly --webroot \
    -w /webroot/certbot \
    --email ${email} \
    -d ${domain} \
    ${staging_cmd} \
    --rsa-key-size 4096 \
    --agree-tos \
    --non-interactive \
    --force-renewal

certbot certificates

# TODO: Push SSL certs to AWS S3