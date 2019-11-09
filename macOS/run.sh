#!/usr/bin/env bash

set -euo pipefail;

VERSION="$(cat ../VERSION)";
IMAGE="quay.io/infraxys-core/infraxys-developer-installer:$VERSION";

docker pull $IMAGE;
docker run -it --rm $IMAGE
