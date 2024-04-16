#!/bin/bash
#
# Do not configure this file.
#

source utils.sh

IP=$1
PASS=$2

echo -e "$LIGHTGREEN=== START DEPLOY ===$NC\n"

cd install_sh

sshpass -p $PASS rsync -avP deb_package/testImageGraph.deb rock@$IP:/tmp/
sshpass -p $PASS ssh rock@$IP 'dpkg -i /tmp/testImageGraph.deb'

cd ../

echo -e "$LIGHTGREEN=== END DEPLOY ===$NC\n"