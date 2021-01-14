#!/usr/bin/env bash

set -e;

if [ "$(uname -s)" == "Darwin" -a "$(id -u)" -eq 0 ]; then
    echo "-"
    echo "You should not run this script under root on a Mac.";
    echo "-"
    exit 1
fi;

if [ -z "$INFRAXYS_ROOT_DIR" ]; then
    echo "Please enter the root directory for Infraxys."
    echo "  All files will be stored here."
    echo "  !!! Make sure this directory can be mounted by Docker and that it is empty."

    read -p "Directory name: [/opt/infraxys/infraxys-developer]: " INFRAXYS_ROOT_DIR;
    INFRAXYS_ROOT_DIR="${INFRAXYS_ROOT_DIR:-/opt/infraxys/infraxys-developer}";
fi;

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

if ! docker network inspect infraxys-run >/dev/null 2>&1; then
    echo "Creating network 'infraxys-run'."
    docker network create -d bridge -o "com.docker.network.bridge.name"="infraxys-run0" infraxys-run;
fi;

echo "Launching installer now";

if [ "$NO_PULL" != "true" ]; then
    echo "Pulling latest version of $IMAGE.";
    docker pull $IMAGE;
fi;

sudo docker run -it --rm \
    -e "VERSION=$VERSION" \
    -e "INFRAXYS_ROOT_DIR=$INFRAXYS_ROOT_DIR" \
    -e "INSTALL_MODE=LINUX" \
    -e "INFRAXYS_PORT=$INFRAXYS_PORT" \
    -e "INFRAXYS_USERNAME=$INFRAXYS_USERNAME" \
    -e "INFRAXYS_FULLNAME=$INFRAXYS_FULLNAME" \
    -e "CONTAINER_PREFIX=$CONTAINER_PREFIX" \
    -e "NETWORK_PREFIX=$NETWORK_PREFIX" \
    -e "TOMCAT_IMAGE_VERSION=$TOMCAT_IMAGE_VERSION" \
    -v "$INFRAXYS_ROOT_DIR":/infraxys-root:rw \
    $IMAGE

username="$(id -un)";
groupname="$(id -gn)";

echo "Setting owner of Infraxys files to $username:$groupname";
sudo chown -R "$username":"$groupname" "$INFRAXYS_ROOT_DIR";

cd "$INFRAXYS_ROOT_DIR/bin";

. "$INFRAXYS_ROOT_DIR/config/variables";
if [ "$NO_PULL" == "true" ]; then
    ./up.sh;
else
    docker-compose -f stack.yml pull;
    ./up.sh;

    echo "Pulling the latest provisioning container.";
    docker pull quay.io/jeroenmanders/infraxys-provisioning-server:ubuntu-full-18.04-latest;
fi;

if [ -f "/infraxys/certs/localhost.crt" ]; then
    echo "Retrieving localhost certificate.";
    docker cp infraxys-developer-web:/infraxys/certs/localhost.crt .;

    if [ "$(uname -s)" == "Darwin" ]; then
        echo "Add localhost certificate to the System chain.";
        sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain localhost.crt;
        rm localhost.crt;
    else
        echo "Copying the localhost certificate to the ca-certificates directory.";
        cp localhost.crt /usr/local/share/ca-certificates/infraxys-localhost.crt;
        update-ca-certificates;
    fi;
fi;