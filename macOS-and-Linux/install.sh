#!/usr/bin/env sh

set -eu;

echo "Please enter the root directory for Infraxys."
echo "  All files will be stored here."
echo "  !!! Make sure this directory can be mounted by Docker and that it is empty."

read -p "Directory name: [/opt/infraxys/infraxys-developer]: " INFRAXYS_ROOT_DIR;

INFRAXYS_ROOT_DIR="${INFRAXYS_ROOT_DIR:-/opt/infraxys/infraxys-developer}";

if [ -d "$INFRAXYS_ROOT_DIR" -a -n "$(ls -A "$INFRAXYS_ROOT_DIR" > /dev/null 2>&1)" ]; then
  echo "Directory $INFRAXYS_ROOT_DIR is not empty. Not making any changes to it.";
  exit 1;
fi;

VERSION="$(cat ../VERSION)";
IMAGE="quay.io/jeroenmanders/infraxys-developer-installer:$VERSION";

echo "==="
echo "Your password might be asked since we're using sudo.";
echo "==="
echo
sudo mkdir -p "$INFRAXYS_ROOT_DIR/data/mysql";

sudo chown -R 2000:2000 "$INFRAXYS_ROOT_DIR";
sudo chmod -R a+w "$INFRAXYS_ROOT_DIR";

echo "Launching installer now";

# docker pull $IMAGE;
sudo docker run -it --rm \
  -e "VERSION=$VERSION" \
  -e "INFRAXYS_ROOT_DIR=$INFRAXYS_ROOT_DIR" \
  -e "INSTALL_MODE=LINUX" \
  -v "$INFRAXYS_ROOT_DIR":/infraxys-root:rw \
  $IMAGE

username="$(id -un)";
groupname="$(id -gn)";

echo "Setting owner of Infraxys files to $username:$groupname";
sudo chown -R "$username":"$groupname" "$INFRAXYS_ROOT_DIR";


cd "$INFRAXYS_ROOT_DIR/bin";
./up.sh;

echo "Retrieving localhost certificate.";
docker cp infraxys-developer-web:/infraxys/certs/localhost.crt .;

if [ "$(uname)" == "Darwin" ]; then
  sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain localhost.crt;
  rm localhost.crt;
else
  cp localhost.crt /usr/local/share/ca-certificates/infraxys-localhost.crt;
  update-ca-certificates;
fi;