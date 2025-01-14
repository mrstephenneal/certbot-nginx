#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Optional TAG argument (if set, only the specified image will be built)
TAG=${1:-null}

# Optional PLATFORM argument (if none provided, both will be built)
PLATFORM=${2:-"linux/amd64,linux/arm64"}

# Check if the TAG variable is set
if [ "$TAG" != null ]

  # Only build & push one image
  then
    docker buildx build \
      	--push \
      	-t stephenneal/certbot:"${TAG}" \
      	--platform "${PLATFORM}" \
      	"${DIR}"/"${TAG}"/

  # Build & push all images
  else
    sh "${DIR}"/build.sh

    docker push stephenneal/certbot:v7
    docker push stephenneal/certbot:v8
    docker push stephenneal/certbot:v9
    docker push stephenneal/certbot:v10
    docker push stephenneal/certbot:v11
    docker push stephenneal/certbot:v12
    docker push stephenneal/certbot:v13
    docker push stephenneal/certbot:v14
    docker push stephenneal/certbot:v15
fi