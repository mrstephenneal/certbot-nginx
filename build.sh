#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

docker build -t stephenneal/certbot-nginx:v1 "${DIR}"/v1/
docker build -t stephenneal/certbot-nginx:v2 "${DIR}"/v2/
docker build -t stephenneal/certbot-nginx:v3 "${DIR}"/v3/
docker build -t stephenneal/certbot-nginx:v4 "${DIR}"/v4/
docker build -t stephenneal/certbot-nginx:v5 "${DIR}"/v5/
docker build -t stephenneal/certbot-nginx:v6 "${DIR}"/v6/