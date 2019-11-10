#!/usr/bin/env sh

set -euo pipefail;

echo "Please enter the root directory for Infraxys."
echo "  All files will be stored here."
echo "  !!! Make sure this directory can be mounted by Docker and that it is empty."

read -p "Directory name: [/opt/infraxys-developer]: " INFRAXYS_ROOT_DIR;

INFRAXYS_ROOT_DIR="${INFRAXYS_ROOT_DIR:-/opt/infraxys/developer-dev}";

if [ -d "$INFRAXYS_ROOT_DIR" && -n "$(ls -A "$INFRAXYS_ROOT_DIR")" ]; then
  echo "Directory $INFRAXYS_ROOT_DIR is not empty. Not making any changes to it.";
  exit 1;
fi;

VERSION="$(cat ../VERSION)";
IMAGE="quay.io/jeroenmanders/infraxys-developer-installer:$VERSION";

mkdir -p "$INFRAXYS_ROOT_DIR";
chown 2000:2000 "$INFRAXYS_ROOT_DIR";

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