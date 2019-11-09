#!/usr/bin/env bash

set -euo pipefail;

INFRAXYS_ROOT_DIR="/opt/infraxys/developer-dev";
VERSION="$(cat ../VERSION)";
IMAGE="quay.io/jeroenmanders/infraxys-developer-installer:$VERSION";

if [ -d "$INFRAXYS_ROOT_DIR" ]; then
  echo "Directory $INFRAXYS_ROOT_DIR already exists. Not making any changes to it.";
  exit 1;
fi;

mkdir -p "$INFRAXYS_ROOT_DIR";

docker pull $IMAGE;
docker run -it --rm \
  -e "VERSION=$VERSION" \
  -e "INFRAXYS_ROOT_DIR=$INFRAXYS_ROOT_DIR" \
  -v $INFRAXYS_ROOT_DIR:/infraxys-root:rw \
  $IMAGE

username="$(id -un)";
groupname="$(id -gn)";

echo "Setting owner of Infraxys files to $username:$groupname";
chown -R "$username":"$groupname" "$INFRAXYS_ROOT_DIR";

cd "$INFRAXYS_ROOT_DIR/bin";
./up.sh;